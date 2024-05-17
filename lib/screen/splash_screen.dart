import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: kHorizontalMargin, vertical: kVerticalMargin),
        child: Column(children: [
          Image.asset(Assets.images.Logo),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: kVerticalMargin),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width * 2, height * 0.07),
                  backgroundColor: Color(0xFF614E7E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: ResponsiveText(
                  "Get Started",
                  fontSize: 24,
                  fontFamily: 'Times',
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFFFCFCFC),
                ),
                onPressed: () {
                  {
                    MaterialPageRoute(
                      builder: (context) => nScreen(),
                    );
                  }
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
