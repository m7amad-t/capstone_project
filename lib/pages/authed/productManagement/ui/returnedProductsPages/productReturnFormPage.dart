import 'package:flutter/material.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class ProductReturnForm extends StatefulWidget {
  const ProductReturnForm({super.key});

  @override
  State<ProductReturnForm> createState() => _ProductReturnFormState();
}

class _ProductReturnFormState extends State<ProductReturnForm> {

  

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme; 

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },

        child : Container(
          padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10,),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // top gap 
                gap(height: AppPaddings.p30),
                Text('Return Product Form' ,
                style: _textStyle.displayMedium,
                ), 

                gap(height: AppSizes.s10), 

              ],
            ),
          ),
        )
      ),
    ) ; 
  }
}