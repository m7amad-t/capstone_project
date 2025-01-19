import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/cartBloc/cart_bloc_bloc.dart';
import 'package:shop_owner/shared/UI/appBar.dart';
import 'package:shop_owner/shared/UI/drawer.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class RootPage extends StatefulWidget {
  final StatefulNavigationShell child;
  const RootPage({
    super.key,
    required this.child,
  });

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late final bool isAdmin;
  @override
  void initState() {
    super.initState();
    isAdmin = locator<AuthedUser>().user.admin;
    setupAppDialogs(context);
    setupAppDynamicSizes(context);
    setupAllLocalization(context);
  }

  @override
  Widget build(BuildContext context) {
    // lock rotation to portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    
    return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(),
          endDrawer: appDrawer(context),
          body: widget.child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                  blurRadius: 0.5,
                  spreadRadius: 0.5
                  // offset: Offset(0, 1),
                  ),
            ]),
            child: LayoutBuilder(builder: (context, constraints) {
              double preferedSize = 430;

              if (constraints.maxWidth > preferedSize) {
                preferedSize = constraints.maxWidth;
              }

              return SizedBox(
                width: constraints.maxWidth,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    width: preferedSize,
                    child: SalomonBottomBar(
                      itemShape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.s8),
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      currentIndex: !isAdmin
                          ? widget.child.currentIndex == 5
                              ? 3
                              : widget.child.currentIndex
                          : widget.child.currentIndex,
                      selectedColorOpacity: 0.0,
                      onTap: (index) {
                        widget.child.goBranch(!isAdmin
                            ? index == 3
                                ? 5
                                : index
                            : index);
                      },
                      items: [
                        /// Home
                        SalomonBottomBarItem(
                          icon: const Icon(Icons.sell_outlined),
                          title: Text(context.translate.home),
                          selectedColor: AppColors.primary,
                          activeIcon: const Icon(Icons.sell_rounded),
                        ),

                        /// cart
                        SalomonBottomBarItem(
                          icon: BlocBuilder<CartBloc, CartBlocState>(
                            builder: (context, state) {
                              bool show = false;
                              if (state is GotCart) {
                                show = state.cartData.isNotEmpty;
                              }
                              if (state is CartItemUpdated) {
                                show = state.cartData.isNotEmpty;
                              }

                              return badges.Badge(
                                showBadge: show,
                                child: const Icon(
                                  Icons.shopping_cart_outlined,
                                ),
                              );
                            },
                          ),
                          title: Text(context.translate.cart),
                          selectedColor: AppColors.primary,
                          activeIcon: const Icon(
                            Icons.shopping_cart_rounded,
                          ),
                        ),

                        //
                        SalomonBottomBarItem(
                          icon: const Icon(
                            Icons.inventory_2_outlined,
                          ),
                          title: Text(context.translate.inventory),
                          selectedColor: AppColors.primary,
                          activeIcon: const Icon(
                            Icons.inventory_2_rounded,
                          ),
                        ),

                        // analytics
                        if (isAdmin)
                          SalomonBottomBarItem(
                            icon: const Icon(Icons.analytics_outlined),
                            title: Text(context.translate.analytics),
                            selectedColor: AppColors.primary,
                          ),

                        // expenses
                        if (isAdmin)
                          SalomonBottomBarItem(
                            icon: const Icon(Icons.receipt_outlined),
                            title: Text(context.translate.expenses),
                            selectedColor: AppColors.primary,
                            activeIcon: const Icon(Icons.receipt_rounded),
                          ),

                        //  profile
                        SalomonBottomBarItem(
                          icon: const Icon(Icons.person_outline_rounded),
                          title: Text(context.translate.profile),
                          selectedColor: AppColors.primary,
                          activeIcon: const Icon(Icons.person),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
     

    // NavigationBar(
    //   height: AppSizes.s60,
    //   backgroundColor: Colors.transparent,
    //   elevation: 0,
    //   shadowColor: AppColors.primary,
    //   selectedIndex: widget.child.currentIndex,
    //   indicatorColor: AppColors.onPrimary,
    //   onDestinationSelected: (index) {
    //     widget.child.goBranch(index);
    //   },
    //   destinations: const [
    //     NavigationDestination(
    //       selectedIcon: Icon(Icons.home , color : AppColors.primary) ,
    //       icon: Icon(Icons.home),
    //       label: 'Home',
    //     ),
    //     NavigationDestination(
    //       icon: Icon(Icons.inventory),
    //       label: 'Products',
    //     ),
    //   ],
    // ),
  }
}
