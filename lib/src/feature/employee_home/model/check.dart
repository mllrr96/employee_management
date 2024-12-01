import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Check {
  final String? id;
  final String? employeeId;
  final DateTime? date;
  final DateTime? start;
  final DateTime? end;
  final DateTime? breakStart;
  final DateTime? breakEnd;

  Check({
    this.id,
    this.employeeId,
    this.date,
    this.start,
    this.end,
    this.breakStart,
    this.breakEnd,
  });

  Check.empty()
      : id = null,
        employeeId = null,
        date = null,
        start = null,
        end = null,
        breakStart = null,
        breakEnd = null;

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        id: json['id'] as String?,
        employeeId: json['employeeid'] as String?,
        date: (json['date'] as Timestamp?)?.toDate(),
        start: (json['start-time'] as Timestamp?)?.toDate(),
        end: (json['end-time'] as Timestamp?)?.toDate(),
        breakStart: (json['start-break'] as Timestamp?)?.toDate(),
        breakEnd: (json['end-break'] as Timestamp?)?.toDate(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'employeeid': employeeId,
        'date': date,
        'start-time': start,
        'end-time': end,
        'start-break': breakStart,
        'end-break': breakEnd,
      };

  Check copyWith({
    String? id,
    String? employeeId,
    DateTime? date,
    DateTime? start,
    DateTime? end,
    DateTime? breakStart,
    DateTime? breakEnd,
  }) =>
      Check(
        id: id ?? this.id,
        employeeId: employeeId ?? this.employeeId,
        date: date ?? this.date,
        start: start ?? this.start,
        end: end ?? this.end,
        breakStart: breakStart ?? this.breakStart,
        breakEnd: breakEnd ?? this.breakEnd,
      );

  List<CheckDetails> get checkDetails {
    final List<CheckDetails> details = [];
    if (start != null) {
      details.add(CheckDetails(type: CheckType.checkIn, time: start));
    }
    if (end != null) {
      details.add(CheckDetails(type: CheckType.checkOut, time: end));
    }
    if (breakStart != null) {
      details.add(CheckDetails(type: CheckType.breakStart, time: breakStart));
    }
    if (breakEnd != null) {
      details.add(CheckDetails(type: CheckType.breakEnd, time: breakEnd));
    }
    return details;
  }
}

class CheckDetails {
  final CheckType type;
  final DateTime? time;

  const CheckDetails({
    required this.type,
    required this.time,
  });

  const CheckDetails.empty()
      : type = CheckType.unknown,
        time = null;

  Color get color {
    switch (type) {
      case CheckType.checkIn:
        return const Color(0xff403572);
      case CheckType.checkOut:
        return const Color(0xffFF5C5C);
      case CheckType.breakStart:
        return const Color(0xff4CAF50);
      case CheckType.breakEnd:
        return const Color(0xff403572);
      default:
        return const Color(0xff403572);
    }
  }
}

enum CheckType {
  checkIn,
  checkOut,
  breakStart,
  breakEnd,
  done,
  unknown;

  String get name {
    switch (this) {
      case CheckType.checkIn:
        return 'Check In';
      case CheckType.checkOut:
        return 'Check Out';
      case CheckType.breakStart:
        return 'Break Start';
      case CheckType.breakEnd:
        return 'Break End';
      case CheckType.done:
        return 'Done';
      default:
        return 'Unknown';
    }
  }

  factory CheckType.fromName(Check check) {
    if (check.start != null && check.end == null) {
      return CheckType.checkIn;
    } else if (check.start != null && check.end != null) {
      return CheckType.checkOut;
    } else if (check.breakStart != null && check.breakEnd == null) {
      return CheckType.breakStart;
    } else if (check.breakStart != null && check.breakEnd != null) {
      return CheckType.breakEnd;
    } else {
      return CheckType.unknown;
    }
  }
}
