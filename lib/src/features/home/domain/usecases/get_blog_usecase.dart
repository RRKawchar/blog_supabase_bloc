import 'package:blog_app/src/core/error/failures.dart';
import 'package:blog_app/src/core/usecase/use_case.dart';
import 'package:blog_app/src/features/home/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/home/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogUseCase implements UseCase<List<BlogEntity>,NoParams>{
  final BlogRepository blogRepository;
  GetBlogUseCase(this.blogRepository);
  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async{
   return await blogRepository.getAllBlogs();
  }

}