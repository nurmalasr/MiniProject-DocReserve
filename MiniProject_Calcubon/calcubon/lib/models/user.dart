class UserModel {
  final String token;
  final String fullname;
  final String tglLahir;
  final String location;

  const UserModel({
    required this.token,
    required this.fullname,
    required this.tglLahir,
    required this.location,
  });
}
