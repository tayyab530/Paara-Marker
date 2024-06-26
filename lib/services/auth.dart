import 'package:firebase_auth/firebase_auth.dart';

final auth = AuthService();

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  late String _errorMessage;
  // ignore: missing_return
  Future<User?> registerWithEandP(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          _auth.currentUser;
        return result.user;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message.toString();
      return null;
    }
  }

  // ignore: missing_return
  Future<User?> loginWithEandP(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
        return result.user;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message!;
      return null;
    }
    
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  String getError() => _errorMessage;

  String getCurrentUserId() => _auth.currentUser!.uid;

  User? isLogedIn(){
    User? _user = _auth.currentUser;
    // var temp = _auth.authStateChanges();
    // temp.listen((event) { _user = event!;});
    return _user; 
  }
  
}
