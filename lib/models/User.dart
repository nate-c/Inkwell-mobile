class User {
  final int userId;
  final String firstName;
  final String lastName;
  final String username;
  int amount;
  int accountId;

  User(this.userId, this.firstName, this.lastName, this.username, this.amount,
      this.accountId);

  User.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        username = json['username'],
        amount = json['amount'],
        accountId = json['account_id'];

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'amount': amount,
        'account_id': accountId,
      };
}
