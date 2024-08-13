import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/order/presentation/view/order_view.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(authViewModelProvider.notifier).getUserById(
            userId: ref.read(authViewModelProvider).loginEntity?.user?.id ?? '',
            onError: (message) {
              showMySnackBar(
                message: message,
                color: Colors.red,
              );
            },
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          //? Profile Image and Full Name or Username
          Row(
            children: [
              //? Profile Image
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Center(
                  child: authState.loginEntity?.user?.image != null
                      ? CircleAvatar(
                          radius: 100.w,
                          backgroundImage: NetworkImage(
                            "${ApiEndpoints.url}/${authState.loginEntity!.user!.image!}",
                          ),
                        )
                      : Text(
                          authState.loginEntity?.user?.firstName
                                  ?.substring(0, 1) ??
                              'U',
                          style: TextStyle(
                            fontSize: 40.h,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
              //? Full Name or Username
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${authState.loginEntity?.user?.firstName ?? ''} ${authState.loginEntity?.user?.lastName ?? ''}',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      authState.loginEntity?.user?.email ?? '---',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //? Horizontal Divider
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          //? Logout Button
          ProfileDescriptionButtons(
            title: 'Edit Profile',
            description: 'Edit your profile',
            fun: () {},
            icon: Icons.edit,
          ),
          ProfileDescriptionButtons(
            title: 'Orders',
            description: 'View your orders',
            fun: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderListPage(),
                ),
              );
            },
            icon: Icons.shopping_bag_rounded,
          ),
          SizedBox(height: 20.h),
          ProfileDescriptionButtons(
            title: 'Logout',
            description: 'Logout from your account',
            fun: () {
              // Alet Dialog
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text(
                      'Are you sure you want to logout?\nYour data will be lost. Want to export your data?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          ref.read(authViewModelProvider.notifier).logout(
                            onError: (message) {
                              showMySnackBar(
                                message: message,
                                color: Colors.red,
                              );
                            },
                            onSuccess: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icons.logout,
          ),
          SizedBox(height: 20.h),
          // // Allow Finger Print,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //? Title adn Description
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //? Title
                  Text(
                    'Allow Finger Print',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  //? Description
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      'Allow finger print to login',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              //? Button
              Switch(
                value: authState.allowFingerPrintLogin,
                onChanged: (value) {
                  if (authState.allowFingerPrintLogin) {
                    ref.read(authViewModelProvider.notifier).removeFingerprint(
                      onError: (message) {
                        showMySnackBar(
                          message: message,
                          color: Colors.red,
                        );
                      },
                    );
                  } else {
                    ref.read(authViewModelProvider.notifier).saveFingerPrint(
                          user: authState.loginEntity!,
                          onError: (message) {
                            showMySnackBar(
                              message: message,
                              color: Colors.red,
                            );
                          },
                        );
                  }
                },
                activeColor: Colors.blue,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProfileDescriptionButtons extends StatelessWidget {
  const ProfileDescriptionButtons({
    super.key,
    required this.title,
    required this.description,
    required this.fun,
    required this.icon,
  });

  final String title;
  final String description;
  final Function fun;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //? Title adn Description
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //? Title
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            //? Description
            SizedBox(
              width: 250.w,
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        //? Button
        GestureDetector(
          onTap: () {
            fun();
          },
          child: Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            // Icon of Add Place
            child: Icon(
              icon,
              size: 30.sp,
              color: Colors.grey[600],
            ),
          ),
        )
      ],
    );
  }
}
