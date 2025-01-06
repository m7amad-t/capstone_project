import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/bloc/cart_bloc_bloc.dart';
import 'package:shop_owner/shared/appBar.dart';
import 'package:shop_owner/shared/drawer.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:badges/badges.dart' as badges;

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
  @override
  void initState() {
    super.initState();
    setupAppDialogs(context);
    setupAppDynamicSizes(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      endDrawer: appDrawer(context),
      body: Stack(children: [
        widget.child,
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).textTheme.bodyLarge!.color!, 
              blurRadius: 0.5,
              spreadRadius: 0.5
              // offset: Offset(0, 1),
            ),
          ]
        ),
        child: SalomonBottomBar(
          itemShape:ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s8), 
          ), 
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          currentIndex: widget.child.currentIndex,
          selectedColorOpacity: 0.0,
          
          onTap: (index) {
            widget.child.goBranch(index);
          },
          items: [
            /// Home
            SalomonBottomBarItem(
        
              icon: const Icon(Icons.sell_outlined),
              title: Text(context.translate.sale),
              selectedColor: AppColors.primary,
              activeIcon: const Icon(Icons.sell_rounded), 
            ),
        
            ///
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.inventory_2_outlined,
              ),
              title: Text(context.translate.product),
        
              selectedColor: AppColors.primary,
              activeIcon:     const Icon(
                Icons.inventory_2_rounded,
              ),
            ),
        
            /// cart
            SalomonBottomBarItem(
              icon: BlocBuilder<CartBloc, CartBlocState>(
                builder: (context, state) {
                  bool show = false; 
                  if(state is GotCart){
                    show = state.cartData.isNotEmpty; 
                  }
                  if(state is CartItemUpdated){
                    show = state.cart.isNotEmpty; 
                  }
        
                  return badges.Badge(
                    showBadge: show,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  );
                },
              ),
              title: Text("Search"),
              selectedColor: AppColors.primary,
            ),
        
            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.analytics_outlined),
              title: Text("Profile"),
              selectedColor: AppColors.primary,
            ),
          ],
        ),
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
