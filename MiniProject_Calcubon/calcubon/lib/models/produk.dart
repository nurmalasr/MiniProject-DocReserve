class Produk {
  final String id;
  final String title;
  final String description;
  final int co2;
  final String image;

  Produk({
    required this.id,
    required this.title,
    required this.description,
    required this.co2,
    required this.image,
  });

  factory Produk.fromJson(Map<String, dynamic> map) {
    return Produk(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      co2: map['co2'],
      image: map['image'],
    );
  }
}
