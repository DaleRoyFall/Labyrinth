import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCloudFirestore {
  static Map<String, dynamic> currUserInfo;

  Future saveUserInfo(User user, String displayName, String imageUrl,
      String birthday, String country) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    String uid = user.uid;
    var currUserDoc = users.doc(uid);

    currUserDoc.set({
      "displayName": displayName,
      "uid": uid,
      "imageUrl": imageUrl,
      "birthday": birthday,
      "country": country
    });
  }

  Future getUserInfo(User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    var doc = users.doc("${user.uid}");
    var userInfo = await doc.get();
    if (userInfo.exists) {
      currUserInfo = userInfo.data();
      print(userInfo.data());
    } else {
      print("Absent");
    }
  }

  Future<QuerySnapshot> getPosts() async {
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    var postList = await posts.get();
    return postList;
  }
}
