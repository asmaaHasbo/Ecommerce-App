import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.itemtId});
  final String itemtId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CartCubit>().emitDeleteProductsCartStates(itemtId: itemtId );
        context.read<CartCubit>().emitGetProductsCartStates();
        
      },
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
        if (state is DelCartSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Product Deleted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AddCartFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Error: happened'),
              backgroundColor: Colors.red,
            ),
          );
        }

        },
        child: Icon(Icons.delete, size: 30.sp, color: Colors.red),
      ),
    );
  }
}
