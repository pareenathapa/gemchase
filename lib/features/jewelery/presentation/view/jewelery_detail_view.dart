import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JewelleryDetailView extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productDescription;
  final double productPrice;

  const JewelleryDetailView({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                productImage,
                height: 200.h,
                width: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              productName,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '\$${productPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              productDescription,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[700],
              ),
            ),
            Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement add to cart functionality here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$productName added to cart')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
