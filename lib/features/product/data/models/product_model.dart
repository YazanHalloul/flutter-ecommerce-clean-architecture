import 'package:technical_assignment/features/product/domain/entities/product_entity.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  final double rating;
  final String? brand;
  final List<ReviewModel> reviews;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    this.brand,
    required this.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      image: json['images'][0],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      brand: json['brand'],
      reviews: (json['reviews'] as List)
          .map((e) => ReviewModel.fromJson(e))
          .toList(),
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      category: category,
      description: description,
      image: image,
      price: price,
      rating: rating,
      brand: brand,
      reviews: reviews.map((e)=>e.toEntity()).toList(), 
    );
  }
}

class ReviewModel {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;
  ReviewModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }

  Review toEntity() {
    return Review(
      rating: rating,
      comment: comment,
      date: date,
      reviewerName: reviewerName,
      reviewerEmail: reviewerEmail,
    );
  }
}
