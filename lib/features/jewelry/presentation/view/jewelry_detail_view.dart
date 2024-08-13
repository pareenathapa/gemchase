import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/cart/presentation/view_model/cart_view_model.dart';

class JewelryDetailView extends ConsumerStatefulWidget {
  final JewelryEntity jewelry;

   JewelryDetailView({super.key, required this.jewelry});

  @override
  ConsumerState<JewelryDetailView> createState() => _JewelryDetailViewState();
}

class _JewelryDetailViewState extends ConsumerState<JewelryDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jewelry.jewelryName ?? 'Jewelry Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.jewelry.jewelryImage != null)
                  Center(
                    child: Image.network(
                      "${ApiEndpoints.url}/${widget.jewelry.jewelryImage!}",
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  widget.jewelry.jewelryName ?? 'Jewelry Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\Rs. ${widget.jewelry.jewelryPrice?.toStringAsFixed(2) ?? 'Price'}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                 SizedBox(height: 16),
                Text(
                  'Category: ${widget.jewelry.jewelryCategory ?? 'Category'}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    //  color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                    widget.jewelry.jewelryDescription ??
                        'Description not available',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      //  color: Colors.green,
                    )),
              ],
            ),
            SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      ref
          .read(cartViewModelProvider.notifier)
          .addToCart(widget.jewelry);

      showMySnackBar(
        message: 'Added to Cart',
      );
    },
    child: const Text('Add to Cart'),
  ),
),

          ],
        ),
      ),
    );
  }
}
