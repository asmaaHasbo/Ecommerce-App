import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/helper/setup_snackbar.dart';
import 'package:laza_ecommerce_app/core/shared/custom_text_form_field.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:laza_ecommerce_app/features/profile/logic/cubit/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfoSection extends StatefulWidget {
  const ProfileInfoSection({super.key});

  @override
  State<ProfileInfoSection> createState() => _ProfileInfoSectionState();
}

class _ProfileInfoSectionState extends State<ProfileInfoSection> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('username') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is Success) {
          setupSnackBarForSuccessState(context, state.message);
          _loadUserData();
          setState(() {
            _isEditing = false;
          });
        } else if (state is Failure) {
          setupSnackbarForFailureState(context, state.error);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withValues(alpha: 0.05),
          //     blurRadius: 10,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Information',
                    style: AppTextStyles.font17w600Black,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                    icon: Icon(
                      _isEditing ? Icons.close : Icons.edit,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your name',
                lableText: 'Name',
                enabled: _isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _emailController,
                hintText: 'Enter your email',
                lableText: 'Email',
                enabled: _isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _phoneController,
                hintText: 'Enter your phone',
                lableText: 'Phone',
                enabled: _isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone is required';
                  }
                  if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              if (_isEditing) ...[
                SizedBox(height: 24.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    final isLoading = state is Loading;
                    return SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ProfileCubit>().updateProfile(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    phone: _phoneController.text,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Save Changes',
                                style: AppTextStyles.font17W600white,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
