import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/app/constants/api_endpoint.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:gemchase_clean_arch/features/order/presentation/view_model/order_view_model.dart';
import 'package:khalti/khalti.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartViewModelProvider).cartItems;
    final totalPrice = cartItems.fold<double>(
      0,
      (previousValue, element) =>
          previousValue + (element.jewelry.jewelryPrice! * element.quantity),
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(
                    "${ApiEndpoints.url}/${item.jewelry.jewelryImage!}",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                  title: Text(item.jewelry.jewelryName ?? 'Jewelry Name'),
                  subtitle: Text(
                    'Rs. ${item.jewelry.jewelryPrice?.toStringAsFixed(2)} x ${item.quantity}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      ref.read(cartViewModelProvider.notifier).removeFromCart(
                            item.jewelry,
                          );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rs. ${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      KhaltiScope.of(context).pay(
                        config: PaymentConfig(
                            amount: 1000,
                            productIdentity: "1",
                            productName: "Walkwise",
                            mobile: "9866155024"),
                        preferences: [PaymentPreference.khalti],
                        onSuccess: (PaymentSuccessModel success) async {
                          for (var element in cartItems) {
                            await ref
                                .read(orderViewModelProvider.notifier)
                                .createOrder(
                                  jewelryId: element.jewelry.id!,
                                  quantity: element.quantity,
                                );
                          }

                          showMySnackBar(message: 'Order placed successfully');
                          ref.read(cartViewModelProvider.notifier).clearCart();
                        },
                        onFailure: (PaymentFailureModel failure) {
                          showMySnackBar(message: 'Order failed');
                        },
                        onCancel: () {
                          showMySnackBar(message: 'Order cancelled');
                        },
                      );
                    },
                    child: const Text('Order'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future<String?> _showOTPSentDialog() {
  //   return showDialog<String>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       String? otp;
  //       return AlertDialog(
  //         title: const Text('OTP Sent!'),
  //         content: TextField(
  //           decoration: const InputDecoration(
  //             label: Text('OTP Code'),
  //           ),
  //           onChanged: (v) => otp = v,
  //         ),
  //         actions: [
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () => Navigator.pop(context, otp),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
}
