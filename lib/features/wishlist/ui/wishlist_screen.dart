import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_for_success_state.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:laza_ecommerce_app/features/wishlist/ui/widgets/wishlist_app_bar.dart';
import 'package:laza_ecommerce_app/features/wishlist/ui/widgets/wishlist_content_list.dart';
import 'package:laza_ecommerce_app/features/wishlist/ui/widgets/wishlist_error_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const WishlistAppBar(),
      body: BlocConsumer<WishlistCubit, WishlistState>(
        listener: (BuildContext context, WishlistState state) {
          if (state is WishlistActionSuccess) {
            setupSnackBarForSuccessState(context, state.message);
            context.read<WishlistCubit>().getWishlist();
          }

          if (state is WishlistActionError) {
            setupSnackbarForFailureState(context, state.errorMessage);
          }
        },
        builder: (BuildContext context, WishlistState state) {
          if (state is WishlistError) {
            return WishlistErrorWidget(errorMessage: state.errorMessage);
          }

          // WishlistContentList handles loading state with redacted
          return const WishlistContentList();
        },
      ),
    );
  }
}
