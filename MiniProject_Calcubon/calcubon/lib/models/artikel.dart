class Artikel {
  final String id;
  final String title;
  final String slug;
  final String body;
  final String author;
  final String image;
  final String createdAt;

  Artikel({
    required this.id,
    required this.title,
    required this.slug,
    required this.body,
    required this.author,
    required this.image,
    required this.createdAt,
  });

  factory Artikel.fromJson(Map<String, dynamic> map) {
    return Artikel(
      id: map['id'],
      title: map['title'],
      slug: map['slug'],
      body: map['body'],
      author: map['author'],
      image: map['image'],
      createdAt: map['createdAt'],
    );
  }
}
