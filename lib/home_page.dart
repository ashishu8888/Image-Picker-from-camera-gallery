import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Camera App'),
      ),
      body: Center(
          child: _image == null ? const Text('No Image') : Image.file(_image!)),
      floatingActionButton: FloatingActionButton(
        onPressed: _optionsDialog,
        child: const Icon(Icons.add_a_photo),
        tooltip: 'Open camera',
      ),
    );
  }

  Future<void> _optionsDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white.withOpacity(1),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                GestureDetector(
                  child: Text('Open Camera'),
                  onTap: openCamera,
                ),
                Padding(padding: EdgeInsets.all(10)),
                GestureDetector(
                  child: Text('Open Gallery'),
                  onTap: openGallery,
                )
              ],
            )),
          );
        });
  }

  Future openCamera() async {
    ImagePicker impicker = ImagePicker();
    var image = await impicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future openGallery() async {
    ImagePicker pic = ImagePicker();
    var image = await pic.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }
}
