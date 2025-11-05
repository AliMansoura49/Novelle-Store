
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:store/data/repositories/products/product_repository_remote.dart';
import 'package:store/data/services/api/product_api_service.dart';
import 'package:store/domain/models/dimension/dimensions.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/domain/repositories/ProductsRepository.dart';


@GenerateMocks([
  Dio,
  ProductApiService,
  ProductRepositoryRemote,
  ProductRepository,
])
void main(){
  
}
final mockProduct = Product(
  id: 1,
  title: "title",
  description: "desc",
  category: "beauty",
  price: 100,
  discountPercentage: 12,
  rating: 3.6,
  stock: 1000,
  tags: [],
  brand: "brand", 
  warrantyInformation: "warrantyInformation", 
  shippingInformation: "shippingInformation", 
  availabilityStatus: "in stock",
  reviews: [],
  images: [],
  dimensions: Dimensions(height: 10, width: 10, depth: 1), 
  thumbnail: "thumbnail",
  weight: 0.2
  );
