import 'dart:developer';

import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemchase_clean_arch/features/cart/presentation/view/cart_view.dart';
import 'package:gemchase_clean_arch/features/wishlist/presentation/view/wishlist_view.dart';

class BottomNavView extends ConsumerStatefulWidget {
  const BottomNavView({super.key});

  @override
  ConsumerState<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends ConsumerState<BottomNavView> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomeBaseView(),
    CartView(),
    WishlistView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0; // Default to Home page
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    log('authState: ${authState.loginEntity}');
    final List<BottomNavigationBarItem> bottomNavItems =
        <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: "Cart",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: "Wishlist",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Profile",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(bottomNavItems[_currentIndex].label!),
        toolbarHeight: 60.h,
        actions: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            margin: EdgeInsets.only(right: 10.w),
            child: Center(
              child: authState.loginEntity?.user?.image != null
                  ? CircleAvatar(
                      radius: 20.w,
                      backgroundImage: NetworkImage(
                        "${ApiEndpoints.url}/${authState.loginEntity!.user!.image!}",
                      ),
                    )
                  : Text(
                      authState.loginEntity?.user?.firstName?.substring(0, 1) ??
                          'U',
                      style: TextStyle(
                        fontSize: 20.h,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
