import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? image;
  final picker = ImagePicker();

  TextEditingController titleController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  Future getImageGallery()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null){
        image = File(pickedFile.path);

      }else
      {
        print("Not selected");
      }
    });
  }

  Future getImageCamera()async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile != null){
        image = File(pickedFile.path);

      }else
      {
        print("Not selected");
      }
    });
  }

  void dialog(context){
    showDialog(context: context,
        builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        content: Container(
          height: 120,
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  getImageCamera();
                  Navigator.pop(context); // for closing camera or gallery
                },
                child: ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                ),
              ),
              InkWell(
                onTap: (){
                  getImageGallery();
                  Navigator.pop(context);
                  },
                child: ListTile(
                  leading: Icon(Icons.photo_library_rounded),
                  title: Text('Gallery'),
                ),
              ),
            ],
          ),
        ),

      );
        }

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: (){
                    dialog(context);
                  },
                  child: Container(
                    height: Get.height * .2,
                    width: Get.width * .9,
                    child: image != null ? ClipRRect(
                      child: Image.file(image!.absolute,
                      width: 100,
                      height: 100,
                        fit: BoxFit.fitHeight,
                      ), //
                  
                    ): Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Form(child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Enter your post title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: textEditingController,
                    minLines: 1,
                    maxLines: 500,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Enter your post Description",
                      border: OutlineInputBorder(),
                    ),
                  ),

                ],
              )),
              SizedBox(height: 20,),
               SizedBox(
                 width: Get.width * .9,
                   height: Get.height * 0.07,
                //  width: double.infinity,
                 child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                     onPressed: (){}, child: Text("Upload"))),





            ],
          ),
        ),
      ),


    );
  }
}
