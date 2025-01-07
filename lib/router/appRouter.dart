import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/cart/ui/cartPage.dart';
import 'package:shop_owner/pages/authed/cart/ui/checkoutPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/CategoriesPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/ProductsPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/categoryEditorPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/productEditorPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/productManagementPage.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/salePage.dart';
import 'package:shop_owner/pages/notAuthed/login/ui/loginPage.dart';
import 'package:shop_owner/pages/notAuthed/splash/splashScreen.dart';
import 'package:shop_owner/root.dart';
import 'package:shop_owner/router/navigationService.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _navigatorKey =
      locator<NavigationService>().key;

  GoRouter get router => GoRouter(
        debugLogDiagnostics: true,
        navigatorKey: _navigatorKey,
        initialLocation: AppRoutes.main,
        routes: <RouteBase>[
          // GoRoute(
          //   path: AppRoutes.root,
          //   redirect: (_, __) => AppRoutes.main,
          // ),
          // splash screen - initial route
          GoRoute(
            path: AppRoutes.main,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: SplashScreen(key: state.pageKey),
            ),
          ),

          // login screen
          GoRoute(
            path: AppRoutes.login,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: LoginPage(key: state.pageKey),
            ),
          ),

          // // product management screen
          // GoRoute(
          //   path: AppRoutes.productManagement,
          //   pageBuilder: (context, state) => NoTransitionPage(
          //     key: state.pageKey,
          //     child: ProductManagementPage(key: state.pageKey),
          //   ),
          //   routes: [
          //     // // update product
          //     // GoRoute(
          //     //   path: AppRoutes.editProduct,
          //     //   pageBuilder: (context, state) {
          //     //     final data = state.extra as Map<String, dynamic>;
          //     //     return NoTransitionPage(
          //     //       key: state.pageKey,
          //     //       child: ProductEditorPage(
          //     //         key: state.pageKey,
          //     //         product: data['product'],
          //     //         categories: data['categories'],
          //     //       ),
          //     //     );
          //     //   },
          //     // ),

          //     // product
          //     GoRoute(
          //       path: AppRoutes.product,
          //       pageBuilder: (context, state) => NoTransitionPage(
          //         key: state.pageKey,
          //         child: ProductsPage(
          //           key: state.pageKey,
          //         ),
          //       ),
          //       routes: <RouteBase>[
          //       // add product
          //         GoRoute(
          //           path: AppRoutes.addProduct,
          //           pageBuilder: (context, state) {
          //             final data = state.extra as Map<String, dynamic>;
          //             return NoTransitionPage(
          //               key: state.pageKey,
          //               child: ProductEditorPage(
          //                 key: state.pageKey,
          //                 product: null,
          //                 categories: data['categories'],
          //               ),
          //             );
          //           },
          //         ),

          //         // update product
          //         GoRoute(
          //           path: AppRoutes.editCategory,
          //           pageBuilder: (context, state) {
          //             final data = state.extra as Map<String, dynamic>;
          //             return NoTransitionPage(
          //               key: state.pageKey,
          //               child: ProductEditorPage(
          //                 key: state.pageKey,
          //                 product: data['product'],
          //                 categories: data['categories'],
          //               ),
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //     // category
          //     GoRoute(
          //       path: AppRoutes.category,
          //       pageBuilder: (context, state) => NoTransitionPage(
          //         key: state.pageKey,
          //         child: CategoriesPage(
          //           key: state.pageKey,
          //         ),
          //       ),
          //       routes: <RouteBase>[
          //       // add ccategory
          //         GoRoute(
          //           path: AppRoutes.addCategory,
          //           pageBuilder: (context, state) {
          //             final data = state.extra as Map<String, dynamic>;
          //             return NoTransitionPage(
          //               key: state.pageKey,
          //               child: CategoryEditorPage(
          //                 key: state.pageKey,
          //                 category: null,
          //                 categories: data['categories'],
          //               ),
          //             );
          //           },
          //         ),

          //         // update category
          //         GoRoute(
          //           path: AppRoutes.editCategory,
          //           pageBuilder: (context, state) {
          //             final data = state.extra as Map<String, dynamic>;
          //             return NoTransitionPage(
          //               key: state.pageKey,
          //               child: CategoryEditorPage(
          //                 key: state.pageKey,
          //                 category: data['category'],
          //                 categories: data['categories'],
          //               ),
          //             );
          //           },
          //         ),
          //       ],
          //     ),

          //   ],
          // ),

          // Shell route for bottom navigation
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) => RootPage(
              key: state.pageKey,
              child: navigationShell,
            ),
            branches: [
              // First tab - Sale tracking
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.home,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: SalePage(key: state.pageKey),
                    ),
                  ),
                ],
              ),

              // Second tab - Product Management
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.productManagement,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: ProductManagementPage(key: state.pageKey),
                    ),
                    routes: [
                      // Products
                      GoRoute(
                        path: AppRoutes.product,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: ProductsPage(key: state.pageKey),
                        ),
                        routes: [
                          // add product
                          GoRoute(
                            path: AppRoutes.addProduct,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: ProductEditorPage(
                                  key: state.pageKey,
                                  product: null,
                                  categories: data['categories'],
                                ),
                              );
                            },
                          ),
                          // edit product
                          GoRoute(
                            path: AppRoutes.editProduct,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: ProductEditorPage(
                                  key: state.pageKey,
                                  product: data['product'],
                                  categories: data['categories'],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Category
                      GoRoute(
                        path: AppRoutes.category,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: CategoriesPage(key: state.pageKey),
                        ),
                        routes: [
                          // add add category
                          GoRoute(
                            path: AppRoutes.addCategory,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: CategoryEditorPage(
                                  key: state.pageKey,
                                  category: null,
                                  categories: data['categories'],
                                ),
                              );
                            },
                          ),
                          // edit category
                          GoRoute(
                            path: AppRoutes.editCategory,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: CategoryEditorPage(
                                  key: state.pageKey,
                                  category: data['category'],
                                  categories: data['categories'],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // First tab - Cart
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.cart,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: CartPage(key: state.pageKey),
                    ),
                    routes: <RouteBase>[
                      GoRoute(
                        path: AppRoutes.cartCheckout,
                        pageBuilder: (context, state) {
                          double discount = 0 ; 
                          Map<String , dynamic> extra  = state.extra as Map<String, dynamic>;
                          if(extra.containsKey('discount') && extra['discount'] != null){
                            discount = extra['discount']; 
                          } 
                          return NoTransitionPage(
                          key: state.pageKey,
                          child: CheckoutPage(key : state.pageKey , discount: discount ,),
                        );}
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
