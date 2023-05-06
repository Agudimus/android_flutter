// ignore: file_names
class Transactions {
  late int? id;
  String title;
  String director;
  double duration;
  double rating;
  String category;

  Transactions({
    this.id,
    required this.title,
    required this.director,
    required this.duration,
    required this.rating,
    required this.category
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'duration': duration,
      'rating': rating,
      'category': category
    };
  }
}
