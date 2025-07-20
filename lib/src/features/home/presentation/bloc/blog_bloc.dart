import 'dart:io';
import 'package:blog_app/src/core/usecase/use_case.dart';
import 'package:blog_app/src/features/home/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/home/domain/usecases/blog_usecase.dart';
import 'package:blog_app/src/features/home/domain/usecases/get_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;
  final GetBlogUseCase getBlogUseCase;

  BlogBloc({required this.uploadBlogUseCase,required this.getBlogUseCase}) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUpload);
    on<GetAllBlogEvent>(_onGetAllBlog);
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
           (r)=>emit(BlogUploadSuccess()),
   );

  }


  void _onGetAllBlog(GetAllBlogEvent event,Emitter<BlogState> emit)async{
    final res=await getBlogUseCase(NoParams());

    res.fold(
        (l)=>emit(BlogFailure(l.message)),
        (r)=>emit(BlogGetAllSuccess(r)),
    );
  }

}
