import 'package:cloud_firestore/cloud_firestore.dart';

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
        'date': date?.toIso8601String(),
        'start-time': start?.toIso8601String(),
        'end-time': end?.toIso8601String(),
        'start-break': breakStart?.toIso8601String(),
        'end-break': breakEnd?.toIso8601String(),
      };
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
