import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/app/constants/api_endpoint.dart';
import 'package:gemchase_clean_arch/features/order/presentation/view_model/order_view_model.dart';

class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({super.key});

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(orderViewModelProvider.notifier).getAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: orderState.isLoading
          ? Center(child: CircularProgressIndicator())
          : orderState.error != null
              ? Center(
                  child: Text(
                    'Error: ${orderState.error!.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : orderState.allOrders == null || orderState.allOrders!.isEmpty
                  ? Center(
                      child: Text(
                        'No orders found',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: orderState.allOrders!.length,
                      itemBuilder: (context, index) {
                        final order = orderState.allOrders![index];
                        final orderDate = DateTime.parse(order.orderDate!);
                        return ListTile(
                          leading: Image.network(
                            "${ApiEndpoints.url}/${order.jewelry!.jewelryImage!}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                          title: Text('${order.jewelry!.jewelryName!}'),
                          subtitle: Text(
                              'Total: \Rs. ${order.totalPrice?.toStringAsFixed(2)}' +
                                  ' | Qty: x${order.quantity}'),
                          trailing: Text(
                              'Order Date: ${orderDate.day}/${orderDate.month}/${orderDate.year}'),
                          onTap: () {},
                        );
                      },
                    ),
    );
  }
}
