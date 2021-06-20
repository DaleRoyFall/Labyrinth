import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class Post {
  Timestamp timestamp;
  String title;
  String subject;
  String content;
  String imageName;
  Image image;
  Completer<ui.Image> completer = new Completer<ui.Image>();

  Post({
    this.timestamp,
    this.title,
    this.subject,
    this.content,
    this.imageName,
    this.image,
  });

  factory Post.fromJson(Map<String, dynamic> post) {
    return Post(
      timestamp: post['timestamp'],
      title: post['title'],
      subject: post['subject'],
      content: post['content'],
      imageName: post['image_name'],
    );
  }

  void getImage() async {
    Reference reference =
        FirebaseStorage.instance.ref().child("post_images/" + imageName);
    String imageUrl = await reference.getDownloadURL();
    image = Image.network(
      imageUrl,
    );

    image.image.resolve(new ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));
  }
}
