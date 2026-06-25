import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:technical_assessment_task/core/utils/app_colors.dart';
import 'package:technical_assessment_task/core/utils/app_routers_strings.dart';
import 'package:technical_assessment_task/core/widgets/responsive_center.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/manager/cubit/cubit/auth_cubit.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/Custom_Button.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/Custom_headline_Text.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/Custom_text_form_feild.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/widgets/create_account_text.dart';

class LoginBodyView extends StatefulWidget {
  const LoginBodyView({super.key});
  @override
  State<LoginBodyView> createState() => _LoginBodyViewState();
}

class _LoginBodyViewState extends State<LoginBodyView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late bool change = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async{
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (state is AuthFailure) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // ⬅️ يقفل اللودر لو مفتوح
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is AuthSuccess) {
      final box = Hive.box('authBox');
      await box.put('token', state.response.token);

      if (context.mounted) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              backgroundColor: AppColors.darkBlue,
              content: Text("Login Successful!"),
              duration: Duration(seconds: 2),
            ),
          );
          context.go(AppRoutersStrings.home);
      }
        }
        },
      builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: SingleChildScrollView(
            child: ResponsiveCenter(
            maxWidth: 480,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    16,
                    MediaQuery.of(context).padding.top + 40,
                    16,
                    32,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/pen_PNG7435.png', width: 90),
                      const SizedBox(height: 20),
                      const Text(
                        "Welcome To Task Manager App",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Please sign in with your mail',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          height: 1.12,
                          letterSpacing: -0.17,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      CustomText(text: "Email", size: 18),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                        controller: emailController,
                        hintText: 'Enter your email',
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
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          text: "Forget Password !",
                          size: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 56),
                      CustomButton(
                        text: 'Login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus(); // ⬅️ يقفل الكيبورد
                            context.read<AuthCubit>().signin(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      const CreateAccountText(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
            ),
          ),
        );
      },
    );
  }
}
