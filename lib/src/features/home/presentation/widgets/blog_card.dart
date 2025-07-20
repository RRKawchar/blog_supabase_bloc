import 'package:blog_app/src/features/home/domain/entities/blog_entity.dart';
import 'package:blog_app/src/features/home/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/calculate_reading_time.dart';

class BlogCard extends StatelessWidget {
  final Color color;
  final BlogEntity blogs;
  const BlogCard({super.key, required this.color, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, BlogViewerPage.route(blogs));
      },
      child: Container(
          height: 200,
          margin:const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          padding:const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color:color,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: blogs.topics.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text(e),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Text(blogs.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              Text("${calculateReadingTime(blogs.content)} min"),
            ],
          )),
    );
  }
}
