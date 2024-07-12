import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/app/constants/api_endpoint.dart';
import 'package:gemchase_clean_arch/core/utils/asset_provider.dart';
import 'package:gemchase_clean_arch/features/jewelery/presentation/viewmodel/jewelery_view_model.dart';



class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
   final ScrollController _scrollController = ScrollController();
 
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jeweleryViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          // Scroll garda feri last ma ho ki haina bhanera check garne ani data call garne
          if (_scrollController.position.extentAfter == 0) {
            ref.read(jeweleryViewModelProvider.notifier).getAllJewelerys();
          }
        }
        return true;
      },
      child: 
    Scaffold(
      body: SingleChildScrollView(
        child: 
         RefreshIndicator(
          // Yo chai pull to refresh ko lagi ho
          color: Colors.green,
          backgroundColor: Colors.amberAccent,
          onRefresh: () async {
            ref.read(jeweleryViewModelProvider.notifier).resetState();
          },
          child: 
        SafeArea(
          child: Column(
            children: [
              Container(
                height: 90,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(Assets.images.Logo),
                      const Icon(Icons.search, size: 28, color: Color(0xffFFFFFF)),
                    ],
                  ),
                ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.amber
                ),
                child: CachedNetworkImage(
                  imageUrl: 'https://th.bing.com/th/id/OIP.0e95TOPnzBGcvwKSGtpmqgHaFn?rs=1&pid=ImgDetMain',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: state.lstJewelerys.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                     final jewelery = state.lstJewelerys[index];
                    return Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: ApiEndpoints.Image+ jewelery.jeweleryImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(jewelery.jeweleryName),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
                if (state.isLoading)
                const CircularProgressIndicator(color: Colors.red),
 
            ],
          ),
        ),
      ),
      )
    )
    );
    
  }
}
