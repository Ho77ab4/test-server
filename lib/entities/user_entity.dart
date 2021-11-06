class UserEntity {
  UserEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.jwtToken,
  });
  
  final String id;
  final String email;
  final String password;
  final String jwtToken;
}
