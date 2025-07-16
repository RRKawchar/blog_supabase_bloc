import 'package:blog_app/src/core/di/init_dependency.dart';
import 'package:blog_app/src/core/theme/app_theme.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkTheme,
      home: LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
