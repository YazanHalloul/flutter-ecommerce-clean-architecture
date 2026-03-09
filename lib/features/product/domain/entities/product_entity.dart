class ProductEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  final double rating;
  final String? brand;
  bool isFavorite;
  final List<Review> reviews;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    this.brand,
    required this.reviews,
    this.isFavorite = false,
  });
}

class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;
  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });
}
