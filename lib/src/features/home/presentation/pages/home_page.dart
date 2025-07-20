import 'package:blog_app/src/core/theme/app_colors.dart';
import 'package:blog_app/src/core/utils/show_snackbar.dart';
import 'package:blog_app/src/features/home/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/src/features/home/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Blogs"),
          centerTitle: true,
          actions: [

            IconButton(onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            }, icon: Icon(CupertinoIcons.add_circled, size: 35,)),

          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if(state is BlogFailure){
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if(state is BlogLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is BlogGetAllSuccess){
              return ListView.builder(
                  itemCount: state.blogEntity.length,
                  itemBuilder: (context, index) {
                    final blogs=state.blogEntity[index];
                  return Container(
                      height: 200,
                      margin:const EdgeInsets.symmetric(horizontal: 16),
                      padding:const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
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
                          Text("2 min"),
                        ],
                      ));
              });
            }

            return const SizedBox();

          },
        )
    );
  }
}


// IconButton(onPressed: ()async{
// await Supabase.instance.client.auth.signOut();
// Navigator.pushAndRemoveUntil(
// context,
// MaterialPageRoute(builder: (_) => LoginPage()),
// (route) => false,
// );
//
// }, icon: Icon(Icons.logout))
