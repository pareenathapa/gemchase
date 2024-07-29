import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemchase_clean_arch/features/addToCart/presentation/view/add_to_cart_base_view.dart';
import 'package:gemchase_clean_arch/features/dashboard/presentation/logic/dashboard_view_model.dart';
import 'package:gemchase_clean_arch/features/dashboard/presentation/view/widgets/custom_navigation_bar.dart';
import 'package:gemchase_clean_arch/features/dashboard/presentation/view/widgets/nav_box.dart';
import 'package:gemchase_clean_arch/features/favorite/presentation/view/favorite_base_view.dart';
import 'package:gemchase_clean_arch/features/home/presentation/view/home_base_view.dart';
import 'package:gemchase_clean_arch/features/profile/presentation/view/profile_base_view.dart';




import '../logic/dashboard_provider.dart';

class DashboardBaseView extends ConsumerStatefulWidget {
  const DashboardBaseView({super.key});

  @override
  ConsumerState<DashboardBaseView> createState() => _DashboardBaseViewState();
}

class _DashboardBaseViewState extends ConsumerState<DashboardBaseView> {
  late DashBoardViewModel viewModel;

  @override
  void initState() {
    viewModel = ref.read(dashBoardViewModelProvider.notifier);
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeBaseView(),
    FavoriteBaseView(),
    AddToCartBaseView(),
    ProfileBaseView(),
  ];

  List<BottomNavigationBarItem> getBottomNavigationItems({
    required int selectedIndex,
  }) {
    return [
      BottomNavigationBarItem(
        icon: NavBox(
          icon: selectedIndex == 0
              ? const Icon(
                  Icons.home,
                  color: Colors.yellow,
                  size: 30,
                )
              : const Icon(
                  Icons.home,
                  size: 30,
                ),
          isActive: selectedIndex == 0,
        ),
        // label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: NavBox(
          icon: selectedIndex == 1
              ? const Icon(
                  Icons.heart_broken,
                  color: Colors.yellow,
                  size: 30,
                )
              : const Icon(
                  Icons.heart_broken,
                  size: 30,
                ),
          isActive: selectedIndex == 1,
        ),
        // label: 'Favorate',
      ),
      BottomNavigationBarItem(
        icon: NavBox(
          icon: selectedIndex == 2
              ? const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.yellow,
                  size: 30,
                )
              : const Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                ),
          isActive: selectedIndex == 2,
        ),
        // label: 'Timesheet',
      ),
      BottomNavigationBarItem(
        icon: NavBox(
          icon: selectedIndex == 3
              ? const Icon(
                  Icons.person,
                  color: Colors.yellow,
                  size: 30,
                )
              : const Icon(
                  Icons.person,
                  size: 30,
                ),
          isActive: selectedIndex == 3,
        ),
        // label: 'Profile',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashBoardViewModelProvider);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.h),
          child: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            titleSpacing: 0,
            toolbarHeight: 0.h,
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: const Text(''),
          ),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Material(
            elevation: 4.0,
            child: Center(
              child: _widgetOptions.elementAt(state.index),
            ),
          ),
        ),
        bottomNavigationBar: Material(
          elevation: 8.0,
          child: CustomBottomNavigationBar(
            items: getBottomNavigationItems(
              selectedIndex: state.index,
            ),
            currentIndex: state.index, // Provide current index
            onItemSelected: (index) {
              viewModel.onTabSelected(
                index,
              );
            },
          ),
        ),
      ),
    );
  }
}