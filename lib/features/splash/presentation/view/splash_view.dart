import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/constants/color_constants.dart';
import 'package:gemchase_clean_arch/core/utils/asset_provider.dart';
import 'package:gemchase_clean_arch/features/auth/presentation/view/login_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    // Wait for 2 seconds and then navigate
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginView(),
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    const kHorizontalMargin = 16.0;
    const kVerticalMargin = 16.0;
    return Scaffold(
      backgroundColor: const Color(kBackground),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: kHorizontalMargin, vertical: kVerticalMargin),
            child: Column(children: [
              Image.asset(Assets.images.Logo),
              const Text('The art of capturing beauty and preserving it for eternity'),
              const SizedBox(height: kVerticalMargin*9,),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: kVerticalMargin),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * 2, height * 0.07),
                      backgroundColor:const Color.fromARGB(255, 77, 143, 177),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Get Started",  
                      style: TextStyle(
                        fontSize: 24,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFCFCFC),
                      ),
                    ),
                    onPressed: () {
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
