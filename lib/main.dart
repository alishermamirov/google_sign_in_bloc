import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in_bloc/firebase_options.dart';
import 'package:google_sign_in_bloc/logic/bloc/signin_bloc.dart';
import 'package:google_sign_in_bloc/screen/home_screen.dart';
import 'package:google_sign_in_bloc/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return HomeScreen();
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Xatolik"),
                ),
              );
            }else if(snapshot.connectionState==ConnectionState.waiting){
               return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
