import 'package:uuid/uuid.dart';

class InstallmentDm {
  String id = const Uuid().v4();
  double amount;
  String dueDate;
  String notes;
  bool isPaid;

  InstallmentDm({
    required this.amount,
    required this.dueDate,
    required this.notes,
    this.isPaid = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'dueDate': dueDate,
      'notes': notes,
      'isPaid': isPaid,
    };
  }

  factory InstallmentDm.fromMap(Map<String, dynamic> map) {
    return InstallmentDm(
      amount: (map['amount'] ?? 0).toDouble(),
      dueDate: map['dueDate'] ?? '',
      notes: map['notes'] ?? '',
      isPaid: map['isPaid'] ?? false,
    )..id = map['id'] ?? const Uuid().v4();
  }
}
