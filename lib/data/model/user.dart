class User {
  String email = "";
  String name = "";
  String phone = "";
  String registerDate = "";
  String token = "";

  User(this.email, this.name, this.phone, this.registerDate, this.token);

  @override
  String toString() {
    return 'User{email: $email, name: $name, phone: $phone, registerDate: $registerDate, token: $token}';
  }
}