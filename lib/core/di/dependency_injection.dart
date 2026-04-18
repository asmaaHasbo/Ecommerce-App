import 'package:get_it/get_it.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/datasources/forget_password_remote.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/datasources/reset_password_remote.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/datasources/verify_reset_code_remote.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/repositories/forget_password_repo.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/repositories/reset_password_repo.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/repositories/verify_reset_code_repo.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/forget_password_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/reset_password_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/verify_otp_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/login/data/datasources/login_remote.dart';
import 'package:laza_ecommerce_app/features/auth/login/data/repositories/login_repo.dart';
import 'package:laza_ecommerce_app/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/data/datasources/sign_up_remote.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/data/repositories/sign_up_repo.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:laza_ecommerce_app/features/cart/data/datasources/cart_remote.dart';
import 'package:laza_ecommerce_app/features/cart/data/repos/cart_repo.dart';
import 'package:laza_ecommerce_app/features/cart/logic/cubit/cart_cubit.dart';
import 'package:laza_ecommerce_app/features/home/data/datasources/home_remote.dart';
import 'package:laza_ecommerce_app/features/home/data/repositories/home_repo.dart';
import 'package:laza_ecommerce_app/features/home/logic/cubit/home_cubit.dart';
import 'package:laza_ecommerce_app/features/wishlist/data/datasources/wishlist_remote.dart';
import 'package:laza_ecommerce_app/features/wishlist/data/repositories/wishlist_repo.dart';
import 'package:laza_ecommerce_app/features/wishlist/logic/cubit/wishlist_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ============ login ===============
  getIt.registerLazySingleton<LoginRemote>(() => LoginRemote());
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  //==================== sign up ====================
  getIt.registerLazySingleton<SignUpRemote>(() => SignUpRemote());
  getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  //==================== forget password ====================
  getIt.registerLazySingleton<ForgetPasswordRemote>(() => ForgetPasswordRemote());
  getIt.registerLazySingleton<ForgetPasswordRepo>(() => ForgetPasswordRepo(getIt()));
  getIt.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIt()));

  //==================== verify OTP ====================
  getIt.registerLazySingleton<VerifyResetCodeRemote>(() => VerifyResetCodeRemote());
  getIt.registerLazySingleton<VerifyResetCodeRepo>(() => VerifyResetCodeRepo(getIt(), getIt()));
  getIt.registerFactory<VerifyOtpCubit>(() => VerifyOtpCubit(getIt()));

  //==================== reset password ====================
  getIt.registerLazySingleton<ResetPasswordRemote>(() => ResetPasswordRemote());
  getIt.registerLazySingleton<ResetPasswordRepo>(() => ResetPasswordRepo(getIt()));
  getIt.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIt()));

  //=============== home ==================
  getIt.registerLazySingleton<HomeRemote>(() => HomeRemote());
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  //================= cart ===============
  getIt.registerLazySingleton<CartRemote>(() => CartRemote());
  getIt.registerLazySingleton<CartRepo>(() => CartRepo(getIt()));
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt()));

  //================= wishlist ===============
  getIt.registerLazySingleton<WishlistRemote>(() => WishlistRemote());
  getIt.registerLazySingleton<WishlistRepo>(() => WishlistRepo(getIt()));
  getIt.registerFactory<WishlistCubit>(() => WishlistCubit(getIt()));
}
