
import 'package:blog_app/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/src/core/services/connection_checker.dart';
import 'package:blog_app/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/src/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/src/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/src/features/home/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/src/features/home/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/src/features/home/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/src/features/home/domain/repositories/blog_repository.dart';
import 'package:blog_app/src/features/home/domain/usecases/blog_usecase.dart';
import 'package:blog_app/src/features/home/domain/usecases/get_blog_usecase.dart';
import 'package:blog_app/src/features/home/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../env/env.dart';

part 'init_dependency.main.dart';
