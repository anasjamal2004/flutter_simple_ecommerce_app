import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn.instance;

  Future<User?> continueWithGoogle() async {
    final String webClientID =
        '341669088223-ej2vf8o029u767lelpqokotsq9c9s3pr.apps.googleusercontent.com';
    try {
      GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(serverClientId: webClientID);
      final GoogleSignInAccount? account = await googleSignIn.authenticate();
      if (account != null) {
        GoogleSignInAuthentication googleAuth = account.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        final userCredential = await auth.signInWithCredential(credential);
        print('-----Successfully Login to Google Account-----');
        print('Username: ${account.displayName}');
        return userCredential.user;
      } else {
        print('-----Account is Empty-----');
        return null;
      }
    } catch (error) {
      print('Something went wrong in sign in: $error');
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      print('Signout from google and auth successfully');
    } catch (error) {
      print('Can not signout from google or Auth issue');
    }
  }
}
