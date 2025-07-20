part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

class BlogInitial extends BlogState {}
class BlogLoading extends BlogState {}
class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}
class BlogSuccess extends BlogState {}
