import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  const UserImagePicker(this.imagePickFn) ;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
   File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.pickImage(
      source: src,
      imageQuality: 50,
      maxWidth: 150,

    );
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage!);
    } else {
      print("No image selected");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
       SizedBox(height: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(

              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,),
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
                icon: Icon(Icons.photo_camera_outlined),
                label: Text("Add Image from Camera",textAlign: TextAlign.center,)),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                icon: Icon(Icons.image_outlined),
                label: Text("Add Image from Gallery",textAlign: TextAlign.center,)),
          ],
        )],
    );
  }
}
