import 'package:blog_app/src/core/utils/calculate_reading_time.dart';
import 'package:blog_app/src/core/utils/format_date.dart';
import 'package:blog_app/src/features/home/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(BlogEntity blogs) =>
      MaterialPageRoute(builder: (_) => BlogViewerPage(blogs: blogs));
  const BlogViewerPage({super.key, required this.blogs});
  final BlogEntity blogs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogs.title.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
               const SizedBox(height: 10),
                Text("By ${blogs.posterName}", style:const TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                Text(
                  "By ${formatedDate(blogs.updatedAt)} .${calculateReadingTime(blogs.content)} min",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(blogs.imageUrl,),
                ),
                const SizedBox(height: 15),
                Text(blogs.content, style:const TextStyle(fontSize: 16,height: 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
