class UserDm {
  final String name;
  final String email;
  final double salary;
  final double balance;
  final String country;

  UserDm({
    required this.name,
    required this.email,
    required this.salary,
    required this.balance,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'salary': salary,
      'balance': balance,
      'country': country,
    };
  }

  factory UserDm.fromMap(Map<String, dynamic> map) {
    return UserDm(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      salary: map['salary']?.toDouble() ?? 0.0,
      balance: map['balance']?.toDouble() ?? 0.0,
      country: map['country'] ?? '',
    );
  }
}
