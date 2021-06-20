import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class LocalFirebaseStorage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> saveFileToStorage(String storageRefPath, File file) async {
    Reference reference = _firebaseStorage.ref(storageRefPath);
    var uploadTask = reference.putFile(file);

    await uploadTask.whenComplete(() => null);
    return uploadTask.snapshot.ref.getDownloadURL();
  }
}
