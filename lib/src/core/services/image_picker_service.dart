import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerServices{
  static const ImagePickerServices _instance=ImagePickerServices._internal();
  static ImagePickerServices get instance=>_instance;
  const ImagePickerServices._internal();


  Future<File?> pickedImage()async{
    try{

      XFile? image=await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image !=null){
        return File(image.path);
      }

      return null;

    }catch(e){
      return null;
    }
  }

}