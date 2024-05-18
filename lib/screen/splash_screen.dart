import 'package:flutter/material.dart';
import 'package:gemchase/core/constants/color_constants.dart';
import 'package:gemchase/core/utils/asset_provider.dart';
import 'package:gemchase/core/utils/util.dart';
import 'package:gemchase/screen/login_screen.dart';
import 'package:gemchase/widgets/responsive_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              const ResponsiveText('The art of capturing beauty and preserving it for eternity'),
              const SizedBox(height: kVerticalMargin*9,),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: kVerticalMargin),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * 2, height * 0.07),
                      backgroundColor: Color.fromARGB(255, 77, 143, 177),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const ResponsiveText(
                      "Get Started",
                      fontSize: 24,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.w400,
                      textColor: Color(0xFFFCFCFC),
                    ),
                    onPressed: () {
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
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
