import 'dart:io';
import 'package:blog_app/src/features/home/domain/usecases/blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;

  BlogBloc({required this.uploadBlogUseCase}) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUpload);
  }

  void _onBlogUpload(BlogUploadEvent event, Emitter<BlogState> emit) async {
   final res= await uploadBlogUseCase(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
   
   
   res.fold(
           (l)=>emit(BlogFailure(l.message)),
           (r)=>emit(BlogSuccess()),
   );

   

  }
}
