import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/admin/presentation/view/admin_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToHome();
    });
  }

  void _navigateToHome() {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    ref.read(authViewModelProvider.notifier).checkFingerPrint();
    authViewModel.getSavedUser(
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      },
      onSuccess: () {
        final state = ref.read(authViewModelProvider);
        if (state.isSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  state.isAdmin ? AdminDashboard() : const BottomNavView(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: kHorizontalMargin, vertical: kVerticalMargin),
        child: Center(
          child: Image.asset(Assets.images.Logo),
        ),
      ),
    );
  }
}
