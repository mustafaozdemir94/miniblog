import 'dart:convert';
// ignore: unused_import
import 'dart:io';
import "package:http/http.dart" as http;

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({required this.blogId, Key? key}) : super(key: key);
  final String blogId;
  @override
  // ignore: library_private_types_in_public_api
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  List<Blog> blogList = [];
  Blog blog = Blog();
  fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.get(url);
    // ignore: avoid_print
    print(json.decode(response.body));
    final jsonData = json.decode(response.body);
    setState(() {
      blog = Blog.fromJson(jsonData);
      // jsonData.map((json) => Blog.fromJson(json)).toList();
      // print(blogList[0]);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(blog.title == null ? "İçerik yükleniyor" : blog.title!),
      ),
      body: blog.id == null
          ? const Center(child: CircularProgressIndicator())
          // ignore: avoid_unnecessary_containers
          : Container(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(children: [
                    AspectRatio(aspectRatio: 4 / 3, child: Image.network(blog.thumbnail!)),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      blog.content!,
                      style: const TextStyle(letterSpacing: 1.2),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      blog.author!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}
