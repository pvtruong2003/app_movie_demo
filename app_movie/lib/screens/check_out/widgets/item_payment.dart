import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/payment.dart';
import 'package:flutter/material.dart';

class ItemPayment extends StatelessWidget {
  final  Payment payment;
  final VoidCallback onTap;

  const ItemPayment({Key key, this.payment, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => onTap?.call(),
      child: Row(
        children: [
          Image.asset(payment.asset, height: 52, width: 52,),
          const SizedBox(width: 32,),
          Text(payment.label, style: TextStyle(color: AppColor.black, fontSize: AppFontSize.label, fontWeight: AppFontWeight.normal,),),
          Expanded(child: Container()),
          Icon(Icons.check_circle_outline_outlined, color: Colors.pink,)
        ],
      ),
    );
  }
}
