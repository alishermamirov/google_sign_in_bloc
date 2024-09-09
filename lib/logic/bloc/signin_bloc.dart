import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  SigninBloc() : super(SigninInitial()) {
    on<signInRequired>((event, emit) async {
      emit(SigninLoading());
      try {
        final userAccount = await _googleSignIn.signIn();
        if (userAccount == null) return;

        final GoogleSignInAuthentication googleSignInAuthentication =
            await userAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final userCredential = await _auth.signInWithCredential(credential);

        emit(SigninSuccess(user: userCredential.user!));
      } catch (e) {
        emit(SigninError(message: e.toString()));
      }
    });
  }
}
