import 'package:blog_app/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/src/core/common/cubits/app_user/app_user_state.dart';
import 'package:blog_app/src/core/di/init_dependency.dart';
import 'package:blog_app/src/core/theme/app_theme.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/src/features/home/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/src/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => getIt<AppUserCubit>()
        ),
        BlocProvider(
          create: (_) => getIt<AuthBloc>()
        ),
        BlocProvider(
            create: (_) => getIt<BlogBloc>()
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    //final session=Supabase.instance.client.auth.currentSession;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkTheme,
      home:BlocSelector<AppUserCubit,AppUserState,bool>(


        selector: (state) {
          return state is AppUserLoggedIn;

        },
        builder: (BuildContext context, isLoggedIn) {
          if(isLoggedIn){
            return HomePage();
          }
          return LoginPage();
        },
      ),

      builder: EasyLoading.init(),
    );
  }
}


