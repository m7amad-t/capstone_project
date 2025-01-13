// ignore_for_file: no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/cartBloc/cart_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/cartModel.dart';
import 'package:shop_owner/shared/imageDisplayer.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';

class MenuCard extends StatefulWidget {
  final ProductModel product;
  final bool showMoreDetails;
  const MenuCard({
    super.key,
    this.showMoreDetails = false,
    required this.product,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  String get _trimName {
    int maxLength = 20;
    if (widget.product.name.length > maxLength) {
      return '${widget.product.name.substring(0, maxLength)}...';
    }
    return widget.product.name;
  }

  String get _trimDescription {
    int maxLength = 100;
    if (widget.product.description.length > maxLength) {
      return '${widget.product.description.substring(0, maxLength)}...';
    }
    return widget.product.description;
  }

  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _quantityController.dispose();
  }

  Timer? _debounce;

  void _debounceQuantity(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        context.read<CartBloc>().add(
              AddItemToCart(
                product: widget.product,
                quantity: int.parse(
                  _quantityController.text,
                ),
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _textStyle = Theme.of(context).textTheme;
    final isLTR = context.fromLTR;

    return BlocBuilder<CartBloc, CartBlocState>(
      buildWhen: (previous, current) {
        if (current is GotCart) {
          return true;
        }
        if (current is CartItemUpdated) {
          if (current.updatedItem.id == widget.product.id) {
            return true;
          }
        }

        return false;
      },
      builder: (context, state) {
        final _textStyle = Theme.of(context).textTheme;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.showMoreDetails ? AppSizes.s250 : AppSizes.s150,
            maxWidth: AppSizes.s300,
          ),
          child: Card(
            child: Column(
              children: [
                // main section , which is product image, name and description...
                Expanded(
                  flex: 2,
                  child: productCardMainSection(
                      product: widget.product, isLTR: isLTR, isCart: true),
                ),

                // advance section , which is are the total section...
                if (widget.showMoreDetails)
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPaddings.p18,
                          vertical: AppPaddings.p10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSizes.s8),
                          color: AppColors.primary.withAlpha(100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "total",
                              style: _textStyle.bodyMedium!
                                  .copyWith(
                                      color: AppColors.primary),
                            ),
                            // gap(width: AppSizes.s10),
                            Text(
                              _getTotal(state),
                              style:
                                  _textStyle.bodyMedium!.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // quantity controller
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: _getProperWidget(state),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getTotal(CartBlocState state) {
    // first find the element
    late final CartModel? cartItem;
    for (final element in state.cartData) {
      if (element.product.id == widget.product.id) {
        cartItem = element;
      }
    }

    if (cartItem == null) return "\$??";

    double subTotal = widget.product.price * cartItem.quantity;
    double total = subTotal * (1);

    return "\$${total.toStringAsFixed(2)}";
  }


  Widget _loadingCart() {
    return Container();
  }

  Widget _addToCart() {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          context.read<CartBloc>().add(AddItemToCart(product: widget.product));
        },
        child: Container(
          alignment: Alignment.center,
          height: AppSizes.s50 - 2,
          // padding: EdgeInsets.all(AppPaddings.p10),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(100),
            border: Border.all(
              color: AppColors.primary.withAlpha(100),
              width: 3,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(AppSizes.s16),
              bottomLeft: Radius.circular(AppSizes.s16),
            ),
          ),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.primary,
            size: AppSizes.s24,
          ),
        ),
      );
    });
  }

  Widget _cartController(CartModel model) {
    return Builder(
      builder: (context) {
        final bool isRTL = context.fromLTR;
        final _textStyle = Theme.of(context).textTheme;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // add button
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  context.read<CartBloc>().add(
                        AddItemToCart(
                          product: widget.product,
                        ),
                      );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: AppSizes.s50 - 2,
                  // padding: EdgeInsets.all(AppPaddings.p10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.4),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.4),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(isRTL ? 0 : AppSizes.s16),
                      bottomLeft: Radius.circular(!isRTL ? 0 : AppSizes.s16),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.onPrimary,
                    size: AppSizes.s24,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translate.enter_quantity;
                  }
                  if (int.tryParse(value) == null) {
                    return context.translate.enter_valid_quantity;
                  }
                  if (int.parse(value) < 0) {
                    return context.translate.enter_valid_quantity;
                  }

                  return null;
                },
                textAlign: TextAlign.center,
                controller: _quantityController,
                onChanged: _debounceQuantity,
                inputFormatters: [
                  AppInputFormatter.numbersOnly,
                ],
                keyboardType: TextInputType.number,
                style: _textStyle.bodySmall,
                decoration: InputDecoration(
                  fillColor: AppColors.primary.withOpacity(0.4),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary.withOpacity(0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary.withOpacity(0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hintText: context.translate.quantity,
                ),
              ),
            ),

            // remove button
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  context.read<CartBloc>().add(
                        DecrementQuantity(
                          product: widget.product,
                        ),
                      );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: AppSizes.s50 - 2,
                  // padding: EdgeInsets.all(AppPaddings.p10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.4),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.4),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(!isRTL ? 0 : AppSizes.s16),
                      bottomLeft: Radius.circular(isRTL ? 0 : AppSizes.s16),
                    ),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: AppColors.onPrimary,
                    size: AppSizes.s24,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getProperWidget(CartBlocState state) {
    if (state is LoadingCart) {
      return _loadingCart();
    } else if (state is GotCart) {
      // check if item is already in cart
      for (final element in state.cartData) {
        if (element.product.id == widget.product.id) {
          _quantityController.text = element.quantity.toString();

          return _cartController(element);
        }
      }

      return _addToCart();
    } else if (state is CartItemUpdated) {
      // check if item is already in cart
      for (final element in state.cartData) {
        if (element.product.id == widget.product.id) {
          _quantityController.text = element.quantity.toString();
          return _cartController(element);
        }
      }

      return _addToCart();
    }

    return Container();
  }

  Widget cardLTR(context, isLTR, _textStyle, CartBlocState state) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: AppSizes.s140,
        maxWidth: AppSizes.s300,
      ),
      child: Card(
        child: Column(
          children: [
            // Content of the product model
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  //  back  (image)
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: AppSizes.s100,
                          width: 200,
                          child: ImageDisplayerWithPlaceHolder(
                            imageUrl: widget.product.imageUrl,
                          ),
                          // child: Text('SLAAAAA'),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),

                  //  middle (gradeant)
                  Row(
                    mainAxisAlignment:
                        isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Theme.of(context).cardColor,
                                Theme.of(context).cardColor.withOpacity(0.1),
                              ],
                            ),
                            // image: DecorationImage(
                            //   image: NetworkImage(widget.product.imageUrl),
                            //   fit: BoxFit.cover,
                            // ),
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(AppSizes.s16),
                            //   bottomLeft: Radius.circular(AppSizes.s16),
                            // ),
                            // color: Theme.of(context).cardColor,
                          ),
                          // child: Text('SLAAAAA'),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),

                  // front texts
                  Row(
                    mainAxisAlignment:
                        isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    _trimName,
                                    style: _textStyle.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Opacity(
                                    opacity: 0.4,
                                    child: Text(
                                      "\$${widget.product.price}",
                                      style: _textStyle.bodySmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Opacity(
                              opacity: 0.7,
                              child: Text(
                                _trimDescription,
                                style: _textStyle.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(widget.product.quantity.toString(),
                              style: _textStyle.bodyLarge),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // content of the cart data
            Expanded(
              child: Container(
                child: _getProperWidget(state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardRTL(context, isLTR, _textStyle, state) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: AppSizes.s150,
        maxWidth: AppSizes.s300,
      ),
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: productCardMainSection(
                product: widget.product,
                isLTR: isLTR,
              ),
            ),

            // content of the cart data
            Expanded(
              child: Container(
                child: _getProperWidget(state),
              ),
            ),
          ],
        ),
      ),
    );
  }
}