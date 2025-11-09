
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:store/data/repositories/products/product_repository_remote.dart';
import 'package:store/data/services/api/product_api_service.dart';
import 'package:store/domain/models/dimension/dimensions.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/domain/models/review/review.dart';
import 'package:store/ui/features/cart/view_models/cart_view_model.dart';
import 'package:store/ui/features/details/view_models/details_view_model.dart';
import 'package:store/ui/features/favorite/view_models/favorite_view_model.dart';
import 'package:store/ui/features/home/view_models/home_view_model.dart';


@GenerateMocks([
  Dio,
  ProductApiService,
  ProductRepositoryRemote,
])

@GenerateNiceMocks([
  MockSpec<HomeViewModel>(),
  MockSpec<CartViewModel>(),
  MockSpec<FavoriteViewModel>(),
  MockSpec<DetailsViewModel>()
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
  tags: ["tag1", "tag2"],
  brand: "brand", 
  warrantyInformation: "warrantyInformation", 
  shippingInformation: "shippingInformation", 
  availabilityStatus: "in stock",
  reviews: [Review(rating: 4, comment: "comment", date: DateTime(2025), reviewerName: "reviewerName", reviewerEmail: "reviewerEmail")],
  images: ["image1", "image2"],
  dimensions: Dimensions(height: 10, width: 10, depth: 1), 
  thumbnail: "thumbnail",
  weight: 0.2
  );

final mockProduct2 = mockProduct.copyWith(id: 2, title: "title2");
final mockProduct3 = mockProduct.copyWith(id: 3, title: "title3");