import 'dart:io';

import 'package:blog_app/src/core/common/widgets/custom_textfiled.dart';
import 'package:blog_app/src/core/services/image_picker_service.dart';
import 'package:blog_app/src/core/theme/app_colors.dart';
import 'package:blog_app/src/core/utils/pick_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route()=> MaterialPageRoute(builder: (_)=>AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController =TextEditingController();
  final TextEditingController contentController =TextEditingController();


  final List<String> _topicList=['Technology','Business','Programming','Entertainment'];
  List<String> selectedTopic=[];

  File? selectedImage;
  void selectImage()async{
   var file=await ImagePickerServices.instance.pickedImage();
   if(file !=null){
     selectedImage=file;
     setState(() {

     });
   }
  }


  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.done,size: 30,)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              selectedImage !=null?
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Image.file(selectedImage!),
                  ):
              InkWell(
                onTap: (){
                  selectImage();
                },
                child: DottedBorder(
                  options: RectDottedBorderOptions(
                    dashPattern: [15, 6],
                    strokeWidth: 1,
                    padding:const EdgeInsets.all(16),
                    color: Colors.grey,

                  ),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Icon(Icons.folder_open,size: 40,),
                       const SizedBox(height: 10),
                       const Text("Select your image")
                      ],
                    ),
                  )
                ),
              ),

              const SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _topicList.map((e){
                    return  Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: (){

                          if(selectedTopic.contains(e)){
                            selectedTopic.remove(e);
                          }else{
                            selectedTopic.add(e);
                          }
                          setState(() {

                          });

                          print(selectedTopic);
                        },

                        child: Chip(
                          color:selectedTopic.contains(e)?
                          WidgetStatePropertyAll(AppColors.buttonColor):
                          null,
                          label: Text(e),
                          side:selectedTopic.contains(e)?null: BorderSide(
                              color: AppColors.borderColor
                          ),
                        ),
                      ),
                    );
                  }

                ).toList(),
              ),),
              const SizedBox(height: 15),
              CustomTextFiled(
                  controller: titleController,
                  hintText: "Title"),
              const SizedBox(height: 15),
              CustomTextFiled(
                controller: contentController,
                hintText: "Content",maxLines: null,),
            ],
          ),
        ),
      ),

    );
  }
}

