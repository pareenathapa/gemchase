// import 'package:flutter/material.dart';

// class FavoriteBaseView extends StatefulWidget {
//   const FavoriteBaseView({super.key});

//   @override
//   State<FavoriteBaseView> createState() => _FavoriteBaseViewState();
// }

// class _FavoriteBaseViewState extends State<FavoriteBaseView> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Favorite Screen'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteBaseView extends StatefulWidget {
  const FavoriteBaseView({super.key});

  @override
  State<FavoriteBaseView> createState() => _FavoriteBaseViewState();
}

class _FavoriteBaseViewState extends State<FavoriteBaseView> {
  final List<Product> favoriteProducts = [
    Product(name: 'Silver Ring', image: 'assets/images/1719673926019-Silver ring.png'),
    Product(name: 'Silver Bangles', image: 'assets/images/1719674315362-Silver Bangles.png'),
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: const Color(0xffd7ae36),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoriteProducts[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30.h,
                  ),
                  SizedBox(width: 12.w),
                  Image.asset(
                    product.image,
                    height: 60.h,
                    width: 60.h,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String image;

  Product({required this.name, required this.image});
}
