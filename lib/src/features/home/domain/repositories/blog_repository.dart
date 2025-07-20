import 'dart:io';

import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/features/home/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository{
  Future<Either<Failure,BlogEntity>> uploadBlogs({
   required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
});

  Future<Either<Failure,List<BlogEntity>>> getAllBlogs();
}