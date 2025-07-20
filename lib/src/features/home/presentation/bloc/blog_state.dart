part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

class BlogInitial extends BlogState {}
class BlogLoading extends BlogState {}
class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}
class BlogUploadSuccess extends BlogState {}

class BlogGetAllSuccess extends BlogState {
  final List<BlogEntity> blogEntity;
  BlogGetAllSuccess(this.blogEntity);
}
