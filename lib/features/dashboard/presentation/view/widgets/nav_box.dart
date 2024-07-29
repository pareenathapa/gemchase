import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBox extends StatelessWidget {
  const NavBox({
    super.key,
    required this.icon,
    this.isActive = false,
  });

  final Widget icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        isActive
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff0066DD)
                          .withOpacity(0.4), // Adjust color and opacity
                      blurRadius: 23.0,
                      spreadRadius: 0.2, // Adjust shadow spread
                      offset: const Offset(0.0, 0.0), // Adjust shadow offset
                    ),
                  ],
                ),
                // child: Assets.svg.navigationTop.svg(),
              )
            : 0.horizontalSpace,
        Container(
          margin: EdgeInsets.only(
            top: 20.h,
            bottom: 20.h,
          ),
          child: icon,
        ),
      ],
    );
  }
}