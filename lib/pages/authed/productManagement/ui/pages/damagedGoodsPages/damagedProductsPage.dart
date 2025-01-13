import 'package:flutter/material.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class DamagedGoodsPage extends StatefulWidget {
  const DamagedGoodsPage({super.key});

  @override
  State<DamagedGoodsPage> createState() => _DamagedGoodsPageState();
}

class _DamagedGoodsPageState extends State<DamagedGoodsPage> {
  late final ValueNotifier<DateTimeRange?> _slectedRange;
  late final ValueNotifier<bool> _showBackToTopButton;
  late final ScrollController _scrollController;

  void _scrollListener() {
    // print('');
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _slectedRange = ValueNotifier(null);
    _showBackToTopButton = ValueNotifier(false);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _slectedRange.dispose();
    _showBackToTopButton.dispose();
    super.dispose();
  }

  int get _calculateDuration {
    int base = 100;

    base += (_scrollController.offset * 0.5).toInt();
    return base;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);
    return Scaffold(
      floatingActionButton: _animateToTopButton(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            // top gap :
            gap(height: AppPaddings.p30),

            // date range selector : ...
            Text(
              "This is Damaged Goods Page..",
              style: textStyle.displayLarge,
            ),
          ],
        )),
      ),
    );
  }

  Widget? _animateToTopButton() {
    return ValueListenableBuilder(
      valueListenable: _showBackToTopButton,
      builder: (context, value, child) {
        if (value) {
          return FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                0,
                duration: Duration(milliseconds: _calculateDuration),
                curve: Curves.linear,
              );
            },
            child: Icon(
              Icons.keyboard_arrow_up_rounded,
              size: AppSizes.s30,
            ),
          );
        }

        return Container();
      },
    );
  }
}
