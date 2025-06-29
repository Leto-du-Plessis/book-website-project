

class BookSummary {

  final int id;
  final String title;
  final String? tagline;
  final String? summary;
  final String? imageId;

  const BookSummary({
    required this.id,
    required this.title,
    this.tagline,
    this.summary,
    this.imageId,
  });

  factory BookSummary.fromJson(Map<String, dynamic> json) {
    return BookSummary(
      id: json['id'],
      title: json['title'],
      tagline: json['tagline'],
      summary: json['summary'],
      imageId: json['image_id'],
    );
  }

}