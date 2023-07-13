import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      print("trying to sing in");
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      print('Google user is $googleUser');
      if (googleUser != null) {
        print('Google user is not null');
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        print(googleAuth.accessToken);
        print(googleAuth.idToken);
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        print(credential);
        await _auth.signInWithCredential(credential);
        print('Sign in with Google done');
      } else {
        print('Google user is null');
        throw Exception('Google user is null');
      }
    } catch (e) {
      print(e.toString());
      print('found google sign in error');
      rethrow;
    }
  }

  signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }
}
