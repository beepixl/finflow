import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDn8MG9fKxIfXlktXkW9x_u8ybercjkXjA",
            authDomain: "fin-flow-xdoekl.firebaseapp.com",
            projectId: "fin-flow-xdoekl",
            storageBucket: "fin-flow-xdoekl.appspot.com",
            messagingSenderId: "129105788131",
            appId: "1:129105788131:web:ca0b3b40663fcdee6919d6"));
  } else {
    await Firebase.initializeApp();
  }
}
