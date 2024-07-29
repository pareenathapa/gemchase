import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/widgets/app_text_field.dart';

class HomeBaseView extends StatefulWidget {
  const HomeBaseView({super.key});

  @override
  State<HomeBaseView> createState() => _HomeBaseViewState();
}

class _HomeBaseViewState extends State<HomeBaseView> {
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffe8e9eb),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeTopSection(),
            16.verticalSpace,
            AppTextField(
              labelText: 'Search',
              controller: searchTextEditingController,
              onChanged: (value) {},
              borderColor: Colors.black,
              suffixIcon: Container(
                margin: EdgeInsets.all(
                  6.h,
                ),
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.r,
                  ),
                  color: const Color(
                    0xffd7ae36,
                  ),
                ),
                child: const Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              'Category',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            8.verticalSpace,
            Container(
              height: 65.h,
              width: 65.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                color: const Color(
                  0xffd7ae36,
                ),
              ),
              child: const Center(
                child: Text(
                  'All',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              'Popular',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            12.verticalSpace,
            const Expanded(
              child: ProductGridView(),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        0.horizontalSpace,
        Text(
          'Home',
          style: TextStyle(
            fontSize: 20.h,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              180.r,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              180.r,
            ),
            child: Image.asset(
              fit: BoxFit.cover,
              'assets/images/person.png',
              height: 45.h,
              width: 45.h,
            ),
          ),
        )
      ],
    );
  }
}

class ProductGridView extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Silver Ring', image: 'assets/images/1719673926019-Silver ring.png'),
    Product(name: 'Silver Bangles', image: 'assets/images/1719674315362-Silver Bangles.png'),
    // Add more products here
  ];

  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.h,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(product.image),
              SizedBox(height: 10.h),
              Text(product.name),
            ],
          ),
        );
      },
    );
  }
}

class Product {
  final String name;
  final String image;

  Product({required this.name, required this.image});
}
