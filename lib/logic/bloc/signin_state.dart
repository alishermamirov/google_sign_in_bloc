part of 'signin_bloc.dart';

abstract class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninLoading extends SigninState {}

final class SigninSuccess extends SigninState {
  final User user;

  SigninSuccess({required this.user});
}

final class SigninError extends SigninState {
  final String message;

  SigninError({required this.message});
}
