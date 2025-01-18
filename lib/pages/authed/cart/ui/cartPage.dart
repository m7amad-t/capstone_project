import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/cartBloc/cart_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/cartModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/components/menuCard.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with WidgetsBindingObserver {
  late final TextEditingController _discount;
  late final ScrollController _scrollController;

  final ValueNotifier<bool> _isVisible = ValueNotifier(true);
  double _lastScrollPosition = 0;
  final double _interval = 10.0;
  late FocusNode _discountNode;

  void _scrollListener() {
    final currentScroll = _scrollController.offset;

    // if scrolling down
    if ((currentScroll - _lastScrollPosition) > _interval) {
      // Scrolling down
      // check if its displayed
      if (_isVisible.value) {
        _isVisible.value = false;
      }
      _lastScrollPosition = currentScroll;
    }
    // if scrolling up
    else if ((currentScroll - _lastScrollPosition) < -_interval) {
      // Scrolling up
      // check if its already displayed :
      if (!_isVisible.value) {
        _isVisible.value = true;
      }
      _lastScrollPosition = currentScroll;
    }

    // _lastScrollPosition = currentScroll;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _discount = TextEditingController();
    _discountNode = FocusNode();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _isVisible.dispose();
    _discount.dispose();
    _discountNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (mounted) {
      final mediaQuery = MediaQuery.of(context);
      if (mediaQuery.viewInsets.bottom > 0) {
        if (_discountNode.hasFocus) {
          _isVisible.value = true;
        } else {
          _isVisible.value = false;
        }
      } else {
        _isVisible.value = true;
      }
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // main content
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPaddings.p10,
              ),
              child: BlocBuilder<CartBloc, CartBlocState>(
                buildWhen: (previous, current) {
                  if (current is! CartItemUpdated) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  List<CartModel> cartItems = [...state.cartData];

                  if (state is LoadingCart) {
                    return const Center(
                      child: RepaintBoundary(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state.cartData.isEmpty) {
                    return _emptyCartCase(textStyle);
                  }

                  return ListView.builder(
                    itemCount: cartItems.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return MenuCard(
                        product: cartItems[index].product,
                        showMoreDetails: true,
                      ).paddingOnly(
                        top: index == 0 ? AppPaddings.p30 : AppPaddings.p10,
                        bottom:
                            index == cartItems.length - 1 ? AppSizes.s200 : 0,
                      );
                    },
                  );
                },
              ),
            ),

            // check out detail and checkout button
            _checkoutSection(),
          ],
        ),
      ),
    );
  }

  Widget _emptyCartCase(TextTheme textStyle) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.s10,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Image.asset(
              AssetPaths.emptyCart,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                vertical: AppSizes.s10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    context.translate.your_cart_is_empty,
                    style: textStyle.displayMedium,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            GoRouter.of(context).go(AppRoutes.home);
                          },
                          child: Text(
                            context.translate.add_product,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  // checkout section
  Widget _checkoutSection() {
    return BlocBuilder<CartBloc, CartBlocState>(
      builder: (context, state) {
        if (state is LoadingCart || state.cartData.isEmpty) {
          _discount.text = "";

          return Container();
        }

        double total = 0;

        for (final element in state.cartData) {
          total += element.product.price * element.quantity;
        }
        if (state.cartData.length <= 2) {
          _isVisible.value = true;
        }

        final textStyle = Theme.of(context).textTheme;

        return ValueListenableBuilder(
          valueListenable: _isVisible,
          builder: (context, value, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: value ? AppPaddings.p6 : -300,
              left: AppPaddings.p14,
              right: AppPaddings.p14,
              height: AppSizes.s150,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.s8),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        color: AppColors.primary.withAlpha(30),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.p18,
                      vertical: AppPaddings.p10,
                    ),
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.color,
                      color: AppColors.primary.withAlpha(30),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          AppSizes.s8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  context.translate.total,
                                  style: textStyle.displayLarge,
                                ),
                              ),
                              Expanded(
                                child: PriceWidget(
                                  price: total,
                                  style: textStyle.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    context.translate.discount_amount,
                                    style: textStyle.displayMedium,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    focusNode: _discountNode,
                                    inputFormatters: [
                                      AppInputFormatter.price,
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.borderBrand,
                                        ),
                                      ),
                                      hintText: context
                                          .translate.enter_discount_amount,
                                    ),
                                    controller: _discount,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      double discount = 0;

                                      if (_discount.text.isNotEmpty &&
                                          double.tryParse(_discount.text) !=
                                              null) {
                                        discount = double.parse(_discount.text);
                                      }

                                      GoRouter.of(context).push(
                                        "${AppRoutes.cart}/${AppRoutes.cartCheckout}",
                                        extra: {
                                          'discount': discount,
                                        },
                                      );
                                    },
                                    child: Text(
                                      context.translate.check_out,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
