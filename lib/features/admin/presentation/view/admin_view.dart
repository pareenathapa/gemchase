import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/core/common/my_snackbar.dart';
import 'package:gemchase_clean_arch/features/auth/presentation/view/login_view.dart';
import 'package:gemchase_clean_arch/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:gemchase_clean_arch/features/jewelry/presentation/view/jewelry_create_view.dart';
import 'package:gemchase_clean_arch/features/jewelry/presentation/view/jewelry_edit_view.dart';

class AdminDashboard extends ConsumerStatefulWidget {
  const AdminDashboard({super.key});

  @override
  ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends ConsumerState<AdminDashboard> {
  @override
  void initState() {
    super.initState();
    ref.read(jewelryViewModelProvider.notifier).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JewelryCreateView(),
              ),
            );
          },
          child: const Text('Add New Jewelry'),
        ),
      ),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text(
                      'Are you sure you want to logout?\nYour data will be lost. Want to export your data?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          ref.read(authViewModelProvider.notifier).logout(
                            onError: (message) {
                              showMySnackBar(
                                message: message,
                                color: Colors.red,
                              );
                            },
                            onSuccess: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Jewellery Image')),
                DataColumn(label: Text('Jewellery Name')),
                DataColumn(label: Text('Jewellery Price')),
                DataColumn(label: Text('Jewellery Category')),
                DataColumn(label: Text('Jewellery Description')),
                DataColumn(label: Text('Actions')),
              ],
              rows: ref
                      .watch(jewelryViewModelProvider)
                      .allJewelry
                      ?.map((jewelry) {
                    return _buildDataRow(
                      context,
                      jewelry.id ?? "",
                      jewelry.jewelryImage ?? "",
                      jewelry.jewelryName ?? "",
                      "${jewelry.jewelryPrice ?? 0.0}",
                      jewelry.jewelryCategory ?? "",
                      jewelry.jewelryDescription ?? "",
                      ref,
                    );
                  }).toList() ??
                  [],
            ),
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(
    BuildContext context,
    String id,
    String imagePath,
    String name,
    String price,
    String category,
    String description,
    WidgetRef ref,
  ) {
    return DataRow(
      cells: [
        DataCell(Image.network(
          "${ApiEndpoints.url}/${imagePath}",
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        )),
        DataCell(Text(name)),
        DataCell(Text(price)),
        DataCell(Text(category)),
        DataCell(Text(description)),
        DataCell(Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JewelryEditView(
                      jewelry: JewelryModel(
                        id: id,
                        jewelryName: name,
                        jewelryPrice: double.parse(price),
                        jewelryCategory: category,
                        jewelryDescription: description,
                        jewelryImage: imagePath,
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Edit'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                ref.read(jewelryViewModelProvider.notifier).delete(
                      id: id,
                      onError: (message) {
                        showMySnackBar(
                          message: message,
                          color: Colors.red,
                        );
                      },
                      onSuccess: () {
                        showMySnackBar(
                          message: 'Jewellery deleted successfully.',
                          color: Colors.green,
                        );
                        ref.read(jewelryViewModelProvider.notifier).getAll();
                      },
                    );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        )),
      ],
    );
  }
}
