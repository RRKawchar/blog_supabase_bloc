import 'dart:io';

import 'package:blog_app/src/core/error/exceptions.dart';
import 'package:blog_app/src/features/home/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource{
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blogModel,
});
}


class BlogRemoteDateSourceImpl implements BlogRemoteDataSource{
  final SupabaseClient supabaseClient;
  BlogRemoteDateSourceImpl(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel)async {
    
    try{
      final blogData=await supabaseClient.from('myblogs').insert(blogModel.toJson()).select();
      return BlogModel.fromJson(blogData.first);
      
    }catch(e){
      throw ServerException(e.toString());
    }

    
 
  }

  @override
  Future<String> uploadBlogImage({required File image, required BlogModel blogModel}) async{
    try{
     await supabaseClient.storage.from('blog_images').upload(
          blogModel.id,
          image
      );
     
     return supabaseClient.storage.from('blog_images').getPublicUrl(blogModel.id);
      
    }catch(e){
      throw ServerException(e.toString());
    } 
  
  }
  
}