import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/internet_checker.dart';

 
class InternetCheckView extends StatelessWidget {
  const InternetCheckView({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, child){
          final connectStatus = ref.watch(connectivityStatusProvider);
          if(connectStatus == ConnectivityStatus.isConnected){
            return const Text('Internet is connected');
          }else {
            return const Text('No internet connection');
          }
 
        },
      ),
    );
  }
}