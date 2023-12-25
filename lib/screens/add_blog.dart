import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  XFile? selectedImage;
  String title = "";
  String content = "";
  String author = "";

  submit() {
    // Submit fonksiyonunun kodlanması..
  }

  pickImage() async {
    XFile? selectedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = selectedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Yeni Blog Ekle")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                if (selectedImage != null) Image.file(File(selectedImage!.path)),
                ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text("Fotoğraf Seç")),
                TextFormField(
                  decoration: const InputDecoration(label: Text("Blog Başlığı")),
                  onSaved: (newValue) {
                    title = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen bir blog başlığı giriniz";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("Blog İçeriği")),
                  maxLines: 5,
                  onSaved: (newValue) {
                    content = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen bir blog içeriği giriniz";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("Ad Soyad")),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen ad soyad giriniz";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    author = newValue!;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // formun valid olduğu durum
                        _formKey.currentState!.save();
                        submit();
                      }
                    },
                    child: const Text("Blog Ekle"))
              ],
            ),
          ),
        ));
  }
}
