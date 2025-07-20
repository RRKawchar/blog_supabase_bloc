import 'dart:io';

import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/use_case.dart';
import 'package:blog_app/src/features/home/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/home/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase implements UseCase<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlogUseCase(this.blogRepository);

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlogs(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
