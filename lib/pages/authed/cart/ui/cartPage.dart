import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/bloc/cart_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/cardModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/components/menuCard.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: BlocBuilder<CartBloc, CartBlocState>(
      //   builder: (context, state) {
      //     if (state is LoadingCart || state.cartData.isEmpty) {
      //       return Container();
      //     }
      //     return Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Expanded(
      //           child: Padding(
      //             padding: EdgeInsets.symmetric(horizontal: AppPaddings.p12),
      //             child: TextButton(
      //               onPressed: () {
      //                 // insted of this show a dialog , display the recipts..
      //                 context
      //                     .read<CartBloc>()
      //                     .add(PlaceOrder(context: context));
      //               },
      //               child: const Text('Check out '),
      //             ),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),

      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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

                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? AppPaddings.p30 : AppPaddings.p10,
                        bottom: index == cartItems.length - 1
                            ? AppSizes.s200
                            : AppPaddings.p10,
                      ),
                      child: MenuCard(
                        product: cartItems[index].product,
                        showMoreDetails: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<CartBloc, CartBlocState>(
            builder: (context, state) {
              if (state is LoadingCart || state.cartData.isEmpty) {
                return Container();
              }

              double total = 0;
              double subTotal = 0;

              for (final element in state.cartData) {
                total += element.product.price *
                    element.quantity *
                    (1 - element.discount);
                subTotal += element.product.price * element.quantity;
              }

              final _textStyle = Theme.of(context).textTheme;

              return Positioned(
                bottom: AppPaddings.p6,
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
                          color: Colors.transparent,
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
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withAlpha(160),
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
                                    'Total',
                                    style: _textStyle.displayLarge,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "\$${total.toStringAsFixed(2)}",
                                    style: _textStyle.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'SubTotal',
                                    style: _textStyle.displayMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "\$${subTotal.toStringAsFixed(2)}",
                                    style: _textStyle.bodyMedium!.copyWith(
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
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Check out',
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
          ),
        ],
      ),
    );
  }
}
