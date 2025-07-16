import 'package:blog_app/src/core/theme/app_colors.dart';
import 'package:blog_app/src/core/utils/show_snackbar.dart';
import 'package:blog_app/src/core/widgets/custom_textfiled.dart';
import 'package:blog_app/src/core/widgets/k_button.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:blog_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/src/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUpPage extends StatefulWidget {

  static route()=>MaterialPageRoute(builder: (context)=>const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
final TextEditingController nameController =TextEditingController();
final TextEditingController emailController =TextEditingController();
final TextEditingController passwordController =TextEditingController();

  final formKey=GlobalKey<FormState>();


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child:BlocConsumer<AuthBloc,AuthState>(
              builder: (context,state){

                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const  Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                      const SizedBox(height: 30),

                      CustomTextFiled(hintText: "Name",controller: nameController,),
                      const SizedBox(height: 15),
                      CustomTextFiled(hintText: "Email",controller: emailController,),

                      const SizedBox(height: 15),
                      CustomTextFiled(hintText: "Password", isObscure: true,controller: passwordController,),
                      const SizedBox(height: 20),



                      KButton(onPressed: () {
                        if(formKey.currentState!.validate()){
                          context.read<AuthBloc>().add(AuthSignUp(
                            name: nameController.text.trim(),
                            email: emailController.text.trim()
                            , password: passwordController.text.trim(),));
                        }

                      }, text: "Sign up"),

                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,LoginPage.route());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign In',
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
                ) ;
              },
              listener: (context,state){

                if (state is AuthLoading) {
                  EasyLoading.show(status: 'Signing up...');
                } else {
                  EasyLoading.dismiss();
                }

                if (state is AuthSuccess) {
                  Navigator.push(context,HomePage.route());
                }

                if (state is AuthFailure) {
                 showSnackBar(context, state.message);
                }
              }
          ),


        ),
      ),
    );
  }
}
