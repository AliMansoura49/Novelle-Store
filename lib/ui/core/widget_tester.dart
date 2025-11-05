import 'package:flutter/material.dart';
import 'package:store/domain/models/dimension/dimensions.dart';
import 'package:store/domain/models/product/product.dart';
import 'package:store/domain/models/review/review.dart';
import 'package:store/ui/core/theme/theme.dart';
import 'package:store/ui/core/ui/dialogs/success_dialog.dart';
import 'package:store/ui/model/CartItem.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(body: WidgetTester()),
    ),
  );
}

final Review _fakeReview = Review(
  rating: 4,
  comment:
      "“Incredible sound quality and socomfortable.The noise cancellation is a game changer! Worth every penny.”",
  date: DateTime(2022, 12, 12),
  reviewerName: "Alex Morgan",
  reviewerEmail: "alex.m@example.com",
);
final Review _fakeReview2 = Review(
  rating: 2.5,
  comment:
      "“Incredible sound quality and socomfortable.The noise cancellation is a game changer! Worth every penny.”",
  date: DateTime(2022, 12, 12),
  reviewerName: "Amanda Lee",
  reviewerEmail: "amandalee.@example.com",
);
final Product _fakeProduct = Product(
  dimensions: Dimensions(height: 10.2, width: 20.9, depth: 5.5),
  weight: 0.8,
  id: 1,
  title: "Test Product",
  description: "This is a test product description.",
  price: 99.99,
  discountPercentage: 15.0,
  rating: 4.5,
  stock: 20,
  brand: "Test Brand",
  category: "Test Category",
  thumbnail: "https://example.com/thumbnail.jpg",
  images: [
    "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp"
        "https://example.com/image1.jpg",
    "https://example.com/image2.jpg",
  ],
  tags: [],
  warrantyInformation: '',
  shippingInformation: 'It takes 3-5 business days to deliver.',
  availabilityStatus: 'In stock',
  reviews: [_fakeReview, _fakeReview2],
);
final cartItems = [
  CartItem(product: _fakeProduct, quantity: 1),
  CartItem(product: _fakeProduct, quantity: 2),
  CartItem(product: _fakeProduct, quantity: 3),
];

class WidgetTester extends StatefulWidget {
  const WidgetTester({super.key});

  @override
  State<WidgetTester> createState() => _WidgetTesterState();
}

class _WidgetTesterState extends State<WidgetTester> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ShimmerRow")),
      body: Center(
        child: TextButton(
          onPressed: (){
          showDialog(
          context: context,
          barrierDismissible: false, 
          builder: (_)=>SuccessDialog(
            
            subtitle: "Your order has been successfully placed.",
            onButtonClick: (){},

            ));
        }, child: Text("open Dialog"))
      ),
    );
  }
}
