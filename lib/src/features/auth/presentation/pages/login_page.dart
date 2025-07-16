import 'package:blog_app/src/core/utils/show_snackbar.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:blog_app/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_textfiled.dart';
import '../../../../core/widgets/k_button.dart';
import '../../../home/presentation/home_page.dart';

class LoginPage extends StatefulWidget {
  static route()=>MaterialPageRoute(builder: (context)=>const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();

  final formKey=GlobalKey<FormState>();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc,AuthState>(
            builder: (context,state){
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const  Text(
                      "Sign In",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    const SizedBox(height: 30),
                    CustomTextFiled(hintText: "Email",controller: emailController,),

                    const SizedBox(height: 15),
                    CustomTextFiled(hintText: "Password", isObscure: true,controller: passwordController,),
                    const SizedBox(height: 20),

                    KButton(onPressed: () {


                      if(formKey.currentState!.validate()){
                        context.read<AuthBloc>().add(AuthLogin(email: emailController.text.trim(), password: passwordController.text.trim()));
                      }



                    }, text: "Login"),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,SignUpPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            listener: (context,state){
              if (state is AuthLoading) {
                EasyLoading.show(status: 'Signing up...');
              } else {
                EasyLoading.dismiss();
              }

              if(state is AuthFailure){
                showSnackBar(context, state.message);
              }

              if(state is AuthSuccess){
                Navigator.push(context,HomePage.route());
              }
            }
        )
      ),
    );
  }
}
