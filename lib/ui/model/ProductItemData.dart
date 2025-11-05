
import 'package:store/domain/models/product/product.dart';

class ProductItemData{
  final int id;
  final String name;
  final String description;
  final String brand;
  final String imageUrl;
  final double price;
  final double rating;


  ProductItemData({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });

  ProductItemData.fromNetworkModel(Product p):
        id = p.id,
        name = p.title,
        description = p.description,
        brand = p.category,
        imageUrl = p.images[0],
        price = p.price,
        rating = p.rating;

}