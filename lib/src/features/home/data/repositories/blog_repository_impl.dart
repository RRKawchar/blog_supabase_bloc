import 'dart:io';

import 'package:blog_app/src/core/error/exceptions.dart';
import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/services/connection_checker.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:blog_app/src/features/home/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/src/features/home/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/src/features/home/data/models/blog_model.dart';
import 'package:blog_app/src/features/home/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/home/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';


class BlogRepositoryImpl implements BlogRepository{
 final BlogRemoteDataSource blogRemoteDataSource;
 final BlogLocalDataSource blogLocalDataSource;
 final ConnectionChecker connectionChecker;
 BlogRepositoryImpl({required this.blogRemoteDataSource,required this.blogLocalDataSource,required this.connectionChecker});

  @override
  Future<Either<Failure, BlogEntity>> uploadBlogs({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async{
    try{

      if(!await (connectionChecker.isConnected)){
        return left(Failure('No internet connection'));
      }

      BlogModel blogModel=BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updatedAt: DateTime.now()
      );


    final imageUrl=await blogRemoteDataSource.uploadBlogImage(
          image: image,
          blogModel: blogModel,
      );

    blogModel=blogModel.copyWith(
      imageUrl: imageUrl
    );

   final blogData= await blogRemoteDataSource.uploadBlog(blogModel);
   return right(blogData);

    }on ServerException catch(e){
      print("dkdjkfdkf dkfd :$e");
      return left(Failure(e.message));
    }

  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs()async {
    try{
      if(!await (connectionChecker.isConnected)){
         final blogs= blogLocalDataSource.getBlogLocal();
         return right(blogs);
      }
     final blogs=await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadBlogLocal(blogs: blogs);
     return right(blogs);

    }on ServerException catch(e){
      return left(Failure(e.message));
    }
  }

}