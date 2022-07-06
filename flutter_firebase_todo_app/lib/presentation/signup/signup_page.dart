import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/auth/signup_form/signup_form_bloc.dart';
import 'package:flutter_firebase_todo_app/injection.dart';
import 'package:flutter_firebase_todo_app/presentation/signup/widgets/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Sign Up'),
        toolbarHeight: 0,
        brightness: Theme.of(context).brightness,
      ),
      body: BlocProvider(
        create: (context) => sl<SignUpFormBloc>(),
        child: SignUpForm(),
      ),
    );
  }
}
