import 'package:blog_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/src/features/home/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  static route()=>MaterialPageRoute(builder: (context)=>const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          
          IconButton(onPressed: (){
            Navigator.push(context, AddNewBlogPage.route());

          }, icon: Icon(CupertinoIcons.add_circled,size: 35,)),
         
        ],
      ),
      body: Center(child: Text("Home Page"),),
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
