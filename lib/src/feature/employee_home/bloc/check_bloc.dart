import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/src/core/di/di.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'check_event.dart';

part 'check_state.dart';

part 'check_bloc.freezed.dart';

@injectable
class CheckBloc extends Bloc<CheckEvent, CheckState> {
  CheckBloc() : super(const CheckState.initial()) {
    on<_LoadChecks>(_loadChecks);
    on<_UpdateCheck>(_updateCheck);
    on<_CreateCheck>(_createCheck);
    on<_LoadTodayCheck>(_loadTodayCheck);
  }

  Future<void> _loadTodayCheck(
    _LoadTodayCheck event,
    Emitter<CheckState> emit,
  ) async {
    emit(const CheckState.loading());
    try {
      final today = DateTime.now();
      final DateTime startDate = DateTime(
        today.year,
        today.month,
        today.day,
      );
      final DateTime endDate = DateTime(
        today.year,
        today.month,
        today.day,
        23,
        59,
        59,
      );
      final querySnapshot = await _db
          .collection('checks')
          .where(
            'employeeid',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .get();

      final checks = <Check>[];
      for (final doc in querySnapshot.docs) {
        checks.add(
          Check.fromJson(doc.data()),
        );
      }
      if (checks.isEmpty) {
        emit(const CheckState.empty());
      } else {
        emit(CheckState.loaded(checks));
      }
    } catch (e) {
      log(e.toString());
      emit(CheckState.error(e.toString()));
    }
  }

  Future<void> _loadChecks(
    _LoadChecks event,
    Emitter<CheckState> emit,
  ) async {
    emit(const CheckState.loading());
    try {
      final DateTime startDate =
          DateTime(event.date.year, event.date.month, event.date.day);
      final DateTime endDate = DateTime(
        event.date.year,
        event.date.month,
        event.date.day,
        23,
        59,
        59,
      );
      final querySnapshot = await _db
          .collection('checks')
          .where('employeeid', isEqualTo: event.id)
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .get();

      final checks = <Check>[];
      for (final doc in querySnapshot.docs) {
        checks.add(
          Check.fromJson(doc.data()),
        );
      }
      if (checks.isEmpty) {
        emit(const CheckState.empty());
      } else {
        emit(CheckState.loaded(checks));
      }
    } catch (e) {
      log(e.toString());
      emit(CheckState.error(e.toString()));
    }
  }

  Future<void> _updateCheck(
    _UpdateCheck event,
    Emitter<CheckState> emit,
  ) async {
    emit(const CheckState.loading());
    try {
      await _db.collection('checks').doc(event.id).update(event.check.toJson());
      emit(CheckState.loaded([event.check]));
    } catch (e) {
      emit(CheckState.error(e.toString()));
    }
  }

  Future<void> _createCheck(
    _CreateCheck event,
    Emitter<CheckState> emit,
  ) async {
    emit(const CheckState.loading());
    try {
      final result = await _db.collection('checks').add(event.check.toJson());
      await _db.collection('checks').doc(result.id).update({'id': result.id});
      emit(CheckState.loaded([event.check]));
    } catch (e) {
      emit(CheckState.error(e.toString()));
    }
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static CheckBloc get instance => getIt<CheckBloc>();
}
