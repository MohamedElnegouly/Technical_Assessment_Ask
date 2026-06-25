import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:technical_assessment_task/core/utils/app_colors.dart';
import 'package:technical_assessment_task/core/utils/app_routers_strings.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/manager/cubit/cubit/auth_cubit.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/Custom_Button.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/Custom_headline_Text.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/Custom_text_form_feild.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/login_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool change = true;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (state is AuthFailure) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is AuthSuccess) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              backgroundColor: AppColors.darkBlue,
              content: Text("Account created successfully! , please Login"),
              duration: Duration(seconds: 2),
            ),
          );
          context.go(AppRoutersStrings.login);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Center(
                      child: Image.asset('assets/pen_PNG7435.png', width: 100),
                    ),
                    const SizedBox(height: 20),
                    CustomText(text: "Full Name", size: 18),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: 'Enter your full name',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 30),
                    CustomText(text: "Mobile Number", size: 18),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: phoneController,
                      hintText: 'Enter your mobile number',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 30),
                    CustomText(text: "E-mail address", size: 18),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Enter your Email address',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    CustomText(text: "Password", size: 18),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: change,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          change ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            change = !change;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 56),
                    CustomButton(
                      text: 'Sign Up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          context.read<AuthCubit>().signup(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            phone: phoneController.text.trim(),
                          );
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    const LoginText(),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
