import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_methods.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String phone,
  }) async {
    String output = "something went wrong";
    if (phone != "") {
      try {
        await FireStoreMethods()
            .uploadUserDetailsToDb(phone: phone);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else if (phone.isEmpty) {
      output = "Please Enter your phone No";
    }
    return output;
  }
}
