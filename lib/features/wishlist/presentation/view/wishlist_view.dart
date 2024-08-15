import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/app/constants/api_endpoint.dart';
import 'package:gemchase_clean_arch/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:gemchase_clean_arch/features/wishlist/presentation/cubit/wishlist_view_model.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';

class WishlistView extends ConsumerStatefulWidget {
  const WishlistView({super.key});

  @override
  ConsumerState<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends ConsumerState<WishlistView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(wishListViewModelProvider.notifier).getAllWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishlistState = ref.watch(wishListViewModelProvider);

    return Scaffold(
      body: wishlistState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: wishlistState.wishlist.length,
              itemBuilder: (context, index) {
                final JewelryEntity product = wishlistState.wishlist[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Image.network(
                      "${ApiEndpoints.url}/${product.jewelryImage ?? ''}",
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/Default Product Images.png',
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        );
                      },
                    ),
                    title: Text(product.jewelryName ?? 'Unknown'),
                    subtitle: Text(
                        "\$${product.jewelryPrice?.toStringAsFixed(2) ?? '0.00'}"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(cartViewModelProvider.notifier)
                            .addToCart(product);
                      },
                      child: const Text('Add to Cart'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
