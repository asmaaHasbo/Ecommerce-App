// widgets/quantity_control_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/cart/ui/widgets/quantity_button.dart';

class CartCounter extends StatefulWidget {
  int quantity;

  CartCounter({super.key, required this.quantity});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuantityButton(
          icon: Icons.remove,
          onTap: () {
            setState(() {
              widget.quantity <= 1 ? widget.quantity : widget.quantity--;
            });
          },
        ),
        SizedBox(width: 10.w),
        Text(
          widget.quantity.toString(),
          style: AppTextStyles.font17W600white.copyWith(
            color: AppColors.mainColor,
          ),
        ),
        SizedBox(width: 10.w),
        QuantityButton(
          icon: Icons.add,
          onTap: () {
            setState(() {
              widget.quantity++;
            });
          },
        ),
      ],
    );
  }
}
