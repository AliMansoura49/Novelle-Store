import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store/domain/models/dimension/dimensions.dart';
import 'package:store/domain/models/review/review.dart';



part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {

  const factory Product({
    required int id,
    required String title,
    required String description,
    required String category,
    required double price,
    required double discountPercentage,
    required double rating,
    required int stock,
    required List<String> tags,
    required String? brand,
    required String warrantyInformation,
    required String shippingInformation,
    required String availabilityStatus,
    required List<Review> reviews,
    required List<String> images,
    required Dimensions dimensions,
    required String thumbnail,
    required double weight,
  })= _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

}
