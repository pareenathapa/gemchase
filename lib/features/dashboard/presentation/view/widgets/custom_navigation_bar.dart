import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Expanded(
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent, // Remove highlight
            splashColor: Colors.transparent,
            onTap: () => onItemSelected(index),
            child: _buildNavigationItem(item, index == currentIndex),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNavigationItem(
      BottomNavigationBarItem item,
      bool isSelected,
      ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        item.icon,
        if (item.label != null)
          Padding(
            padding: EdgeInsets.only(
              top: 6.h,
              bottom: 15.h,
            ),
            child: Text(
              item.label ?? '',
              style: TextStyle(
                fontSize: 12.76.sp,
                // fontFamily : FontFamily(Font(R.font.montserrat)),
                color: isSelected ? const Color(0xff0066DD) : const Color(0xff51585E),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}