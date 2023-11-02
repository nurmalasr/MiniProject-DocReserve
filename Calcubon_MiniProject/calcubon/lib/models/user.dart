class User {
  final String id;
  final String fullname;
  final String tglLahir;
  final String location;
  User({
    required this.id,
    required this.fullname,
    required this.tglLahir,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      fullname: map['fullname'],
      tglLahir: map['tglLahir'],
      location: map['location'],
    );
  }
}
