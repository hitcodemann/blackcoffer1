
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadUserDetailsToDb({
    required String phone,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "phoneNo": phone,
      "uid": FirebaseAuth.instance.currentUser?.uid,
    });
  }

  Future<void> postVideo({
    required String title,
    required String des,
    required String location,
    required String category,
    required String url,
  }) async {
    DateTime time = DateTime.now();
    String timestamp = time.millisecondsSinceEpoch.toString();
    Map<String,dynamic> data = {
      "postId": timestamp,  // Updating Document Reference
      "title": title,  // Updating Document Reference
      "des": des,  // Updating Document Reference
      "location": location,  // Updating Document Reference
      "videoUrl": url, // Updating Document Reference
      'category': category, // Updating Document Reference
    };
    await firebaseFirestore.collection("posts").doc("$timestamp").set(data);
  }

}
