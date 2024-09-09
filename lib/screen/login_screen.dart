import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in_bloc/logic/bloc/signin_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: BlocConsumer<SigninBloc, SigninState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SigninError) {
              return Center(
                child: Text(state.message),
              );
            }
            return ElevatedButton(
                onPressed: state is SigninLoading
                    ? null
                    : () {
                        context.read<SigninBloc>().add(signInRequired());
                      },
                child: state is SigninLoading
                    ? CircularProgressIndicator()
                    : const Text("Google SignIn"));
          },
        ),
      ),
    );
  }
}
