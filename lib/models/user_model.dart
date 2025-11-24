class UserModel {
  String name;
  String email;
  String phone;
  String address;
  String username;
  String password;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'phone': phone,
    'address': address,
    'username': username,
    'password': password,
  };

  factory UserModel.fromMap(Map map) => UserModel(
    name: map['name'] ?? '',
    email: map['email'] ?? '',
    phone: map['phone'] ?? '',
    address: map['address'] ?? '',
    username: map['username'] ?? '',
    password: map['password'] ?? '',
  );
}
