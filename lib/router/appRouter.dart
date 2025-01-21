import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/cart/ui/cartPage.dart';
import 'package:shop_owner/pages/authed/cart/ui/checkoutPage.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/ui/pages/addExpensesRecordPage.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/ui/pages/addExpensesTypePage.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/ui/pages/expensRecordPage.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/ui/pages/expensesTrackingPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/ui/addingDamagedProductFormPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/ui/damagedProductHistoryPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/ui/damagedProductsPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/UI/pages/boughtedProduct.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/ui/expiredProductsPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/UI/pages/buyingFormPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/UI/pages/buyingPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/catrgoryPages/CategoriesPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/catrgoryPages/categoryEditorPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/productPages/ProductPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/productPages/productDetailPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/productPages/productEditorPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/productReturnFormPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/productReturnPage.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/returnedProductHistory.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/productManagementPage.dart';
import 'package:shop_owner/pages/authed/profile/ui/creatingUserPage.dart';
import 'package:shop_owner/pages/authed/profile/ui/profilepage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/pages/categoriesAnalyticsPage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/pages/expensesAnalyticsPage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/pages/productAnalyticsPage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/pages/productListPresenterPage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/pages/totalRevenuePage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/pages/totalSalePage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/pages/trendingsPage.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/saleAnalyticsPage.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/invoiceModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/returnProductFromInvoicePage.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/saleHistoryPage.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/salePage.dart';
import 'package:shop_owner/pages/notAuthed/login/ui/loginPage.dart';
import 'package:shop_owner/pages/notAuthed/splash/splashScreen.dart';
import 'package:shop_owner/root.dart';
import 'package:shop_owner/router/extraTemplates/expensesExtra.dart';
import 'package:shop_owner/router/extraTemplates/invoiceExtra.dart';
import 'package:shop_owner/router/navigationService.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/errorPage.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _navigatorKey =
      locator<NavigationService>().key;

  GoRouter get router => GoRouter(
        debugLogDiagnostics: true,
        navigatorKey: _navigatorKey,
        initialLocation: AppRoutes.main,
        errorPageBuilder: (context, state) {
          return NoTransitionPage(
            key: state.pageKey,
            child: ErrorPage(
              key: state.pageKey,
            ),
          );
        },
        routes: <RouteBase>[
          // splash screen
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

          // Shell route for bottom navigation
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) => RootPage(
              key: state.pageKey,
              child: navigationShell,
            ),
            branches: [
              // first tab - Sale tracking (home)
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.home,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: SalePage(key: state.pageKey),
                    ),
                    routes: [
                      GoRoute(
                        path: AppRoutes.saleHistory,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: SaleHistoryPage(key: state.pageKey),
                        ),
                        routes: [
                          GoRoute(
                              path: AppRoutes.returnProductFromInvoice,
                              pageBuilder: (context, state) {
                                if (state.extra == null) {
                                  return NoTransitionPage(
                                    key: state.pageKey,
                                    child: ErrorPage(
                                      key: state.pageKey,
                                    ),
                                  );
                                }

                                final data =
                                    state.extra as Map<String, dynamic>;

                                final InvoiceModel invoice =
                                    data[InvoiceRoutingExtra.invoiceField];

                                return NoTransitionPage(
                                  key: state.pageKey,
                                  child: ReturnParoductFromInvoicePage(
                                    invoice: invoice,
                                    key: state.pageKey,
                                  ),
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // second tab - Cart
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
                            double discount = 0;
                            Map<String, dynamic> extra =
                                state.extra as Map<String, dynamic>;
                            if (extra.containsKey('discount') &&
                                extra['discount'] != null) {
                              discount = extra['discount'];
                            }
                            return NoTransitionPage(
                              key: state.pageKey,
                              child: CheckoutPage(
                                key: state.pageKey,
                                discount: discount,
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ),

              // third tab - Product Management
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
                          child: ProductPage(
                            key: state.pageKey,
                          ),
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
                          // produt detail
                          GoRoute(
                            path: AppRoutes.productDetail,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: ProductDetailPage(
                                  product: data['product'],
                                  categories: data['categories'],
                                ),
                              );
                            },
                            routes: [
                              // edit product
                              GoRoute(
                                path: AppRoutes.editProduct,
                                pageBuilder: (context, state) {
                                  final data =
                                      state.extra as Map<String, dynamic>;
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

                      // return product
                      GoRoute(
                        path: AppRoutes.returnedProduct,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: ProductReturnPage(
                            key: state.pageKey,
                          ),
                        ),
                        routes: [
                          // return history
                          GoRoute(
                            path: AppRoutes.returnedProductsHistory,
                            pageBuilder: (context, state) => NoTransitionPage(
                              key: state.pageKey,
                              child: ReturnedProducstHistoryPage(
                                key: state.pageKey,
                              ),
                            ),
                          ),

                          GoRoute(
                              path: AppRoutes.returnProductFrom,
                              pageBuilder: (context, state) {
                                final data =
                                    state.extra as Map<String, dynamic>;

                                return NoTransitionPage(
                                  key: state.pageKey,
                                  child: ReturnProductForm(
                                    key: state.pageKey,
                                    product: data['product'],
                                  ),
                                );
                              }),
                        ],
                      ),

                      // add add category
                      GoRoute(
                        path: AppRoutes.boughtedProducts,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: const Boughtedproducts(),
                        ),
                      ),
                      // buy products
                      GoRoute(
                        path: AppRoutes.buyProducts,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: BuyingPage(
                            key: state.pageKey,
                          ),
                        ),
                        routes: [
                          // add add category
                          GoRoute(
                            path: AppRoutes.buyProductsFrom,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: BuyingProductFormPage(
                                  key: state.pageKey,
                                  product: data['product'],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Damaged products
                      GoRoute(
                        path: AppRoutes.damagedProducts,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: DamagedProductsPage(
                            key: state.pageKey,
                          ),
                        ),
                        routes: [
                          // Damaged history page...
                          GoRoute(
                              path: AppRoutes.damagedProductsHistory,
                              pageBuilder: (context, state) => NoTransitionPage(
                                  key: state.pageKey,
                                  child: const DamagedProductsHistoryPage())),

                          // add damaged products
                          GoRoute(
                            path: AppRoutes.damagedProductForm,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: DamagedProductForm(
                                  key: state.pageKey,
                                  product: data['product'],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Expired products
                      GoRoute(
                        path: AppRoutes.expiredProducts,
                        pageBuilder: (context, state) => NoTransitionPage(
                            key: state.pageKey,
                            child: ExpiredProductsPage(
                              key: state.pageKey,
                            )),
                        routes: [
                          // Damaged history page...
                          GoRoute(
                              path: AppRoutes.damagedProductsHistory,
                              pageBuilder: (context, state) => NoTransitionPage(
                                  key: state.pageKey,
                                  child: const DamagedProductsHistoryPage())),

                          // add damaged products
                          GoRoute(
                            path: AppRoutes.damagedProductForm,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: DamagedProductForm(
                                  key: state.pageKey,
                                  product: data['product'],
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

              // forth tab - analytics
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.saleAnalytics,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: SaleAnalyticPage(key: state.pageKey),
                    ),
                    routes: <RouteBase>[
                      // total revenue
                      GoRoute(
                        path: AppRoutes.totalRevenue,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: TotalRevenuePage(key: state.pageKey),
                        ),
                      ),

                      // total sale
                      GoRoute(
                        path: AppRoutes.totalSale,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: TotalSalePage(key: state.pageKey),
                        ),
                      ),
                    
                      // expenses 
                      GoRoute(
                        path: AppRoutes.expensesAnalytics,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: ExpensesAnalyticsPage(key: state.pageKey),
                        ),
                      ),
                      
                      // trending 
                      GoRoute(
                        path: AppRoutes.trendingAnalytics,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: TrendingProductsPage(key: state.pageKey),
                        ),
                      ),

                      // product list presenster
                      GoRoute(
                        path: AppRoutes.productAnalyticsList,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: ProductListPresenterForAnalytics(
                              key: state.pageKey),
                        ),
                        routes: [
                          // product analytics
                          GoRoute(
                            path: AppRoutes.productAnalytics,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: ProductAnalyticsPage(
                                  key: state.pageKey,
                                  product: data['product'],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      // product list presenster
                      GoRoute(
                        path: AppRoutes.categoryAnalytics,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: CategoriesAnalyticsPage(
                            key: state.pageKey,
                          ),
                        ),
                        routes: [
                          // product analytics
                          GoRoute(
                            path: AppRoutes.productAnalytics,
                            pageBuilder: (context, state) {
                              final data = state.extra as Map<String, dynamic>;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: ProductAnalyticsPage(
                                  key: state.pageKey,
                                  product: data['product'],
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

              // fifth tab - expenses
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.expensesTracking,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: ExpensesTracking(
                        key: state.pageKey,
                      ),
                    ),
                    routes: <RouteBase>[
                      // add new expenses type
                      GoRoute(
                        path: AppRoutes.addExpensesType,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: AddNewExpensesTypePage(
                            key: state.pageKey,
                          ),
                        ),
                      ),

                      // add expenses records
                      GoRoute(
                        path: AppRoutes.addExpesnesRecord,
                        pageBuilder: (context, state) {
                          Map<String, dynamic> extra =
                              state.extra as Map<String, dynamic>;

                          return NoTransitionPage(
                            key: state.pageKey,
                            child: AddExpensesRecordPage(
                              key: state.pageKey,
                              expesnes: extra[ExpensExtra.expensesField],
                            ),
                          );
                        },
                      ),

                      // Expens records
                      GoRoute(
                        path: AppRoutes.expensRecordHistory,
                        pageBuilder: (context, state) {
                          Map<String, dynamic> extra =
                              state.extra as Map<String, dynamic>;

                          return NoTransitionPage(
                            key: state.pageKey,
                            child: ExpensesRecordsPage(
                              key: state.pageKey,
                              expenses: extra[ExpensExtra.expensesField],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),

              // sixth tab - profile
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.profile,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: ProfilePage(
                        key: state.pageKey,
                      ),
                    ),
                    routes: <RouteBase>[
                      // add new user
                      GoRoute(
                        path: AppRoutes.addUser,
                        pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: CreateUserPage(
                            key: state.pageKey,
                          ),
                        ),
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
