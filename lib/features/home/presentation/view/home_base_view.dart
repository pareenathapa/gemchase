import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemchase_clean_arch/app/constants/api_endpoint.dart';
import 'package:gemchase_clean_arch/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';
import 'package:gemchase_clean_arch/features/jewelry/presentation/view/jewelry_detail_view.dart';
import 'package:gemchase_clean_arch/features/jewelry/presentation/view_model/jewelry_view_model.dart';
import 'package:gemchase_clean_arch/features/profile/presentation/profile_view.dart';
import '../../../../core/common/widgets/app_text_field.dart';

class HomeBaseView extends ConsumerStatefulWidget {
  const HomeBaseView({super.key});

  @override
  ConsumerState<HomeBaseView> createState() => _HomeBaseViewState();
}

class _HomeBaseViewState extends ConsumerState<HomeBaseView> {
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchTextEditingController =
      TextEditingController();

  final List<Widget> pages = [
    const HomeBaseView(),
    const Placeholder(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final username =
        ref.watch(authViewModelProvider).loginEntity?.user?.firstName ?? "N/A";

    final categories = ref.watch(jewelryViewModelProvider).categories;

    final selectedCategory =
        ref.watch(jewelryViewModelProvider).selectedCategory ?? 'All';

    final filteredProducts = ref.watch(jewelryViewModelProvider).searchResults;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffe8e9eb),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              labelText: 'Search',
              controller: searchTextEditingController,
              onChanged: (value) => setState(() {}),
              borderColor: Colors.black,
              suffixIcon: Container(
                margin: EdgeInsets.all(6.h),
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: const Color(0xffd7ae36),
                ),
                child: const Icon(Icons.filter_list, color: Colors.white),
              ),
            ),
            16.verticalSpace,
            Text(
              'Category',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            8.verticalSpace,
            CategoryList(
              categories: categories,
              selectedCategory: selectedCategory,
              onCategorySelected: (category) {
                ref
                    .read(jewelryViewModelProvider.notifier)
                    .getByCategory(category);
              },
            ),
            16.verticalSpace,
            Text(
              'Popular',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            12.verticalSpace,
            Expanded(
              child: ProductGridView(
                products: filteredProducts
                    .where((product) => product.jewelryName!
                        .toLowerCase()
                        .contains(
                            searchTextEditingController.text.toLowerCase()))
                    .toList(),
                isTablet: isTablet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTopSection extends StatelessWidget {
  final String username;

  const HomeTopSection({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Home',
          style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.w500),
        ),
        Text(
          username,
          style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color:
                    isSelected ? const Color(0xffd7ae36) : Colors.grey.shade300,
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ProductGridView extends StatelessWidget {
  final List<JewelryEntity> products;
  final bool isTablet;

  const ProductGridView(
      {super.key, required this.products, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 4 : 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.h,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => JewelryDetailView(jewelry: product),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Image.network("${ApiEndpoints.url}/${product.jewelryImage!}",
                    fit: BoxFit.cover),
                SizedBox(height: 10.h),
                Text(product.jewelryName!),
              ],
            ),
          ),
        );
      },
    );
  }
}
