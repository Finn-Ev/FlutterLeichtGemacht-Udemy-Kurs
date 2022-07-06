import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/auth/signup_form/signup_form_bloc.dart';
import 'package:flutter_firebase_todo_app/core/failures/auth_failures.dart';
import 'package:flutter_firebase_todo_app/core/regular_expressions.dart';
import 'package:flutter_firebase_todo_app/presentation/routes/router.gr.dart';
import 'package:flutter_firebase_todo_app/presentation/signup/widgets/signup_button.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    late String email;
    late String password;

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      if (!EMAIL_REG_EX.hasMatch(value)) {
        return 'Please enter a valid email';
      }
      email = value;
      return null;
    }

    String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
      password = value;
      return null;
    }

    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listenWhen: (previous, current) =>
          previous.authFailureOrSuccessOption != current.authFailureOrSuccessOption &&
          previous.isSubmitting != current.isSubmitting,
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {}, // Option is none, do nothing
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                  (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          mapFailureToMessage(failure),
                          style: themeData.textTheme.bodyText1,
                        ),
                      ),
                    );
                  },
                  (success) => AutoRouter.of(context).replace(const HomePageRoute()),
                ));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              const SizedBox(
                height: 80.0,
              ),
              Text(
                "Welcome",
                style: themeData.textTheme.headline1!.copyWith(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Please register or sign-in to continue",
                style: themeData.textTheme.headline1!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: validatePassword,
                textInputAction: TextInputAction.done,
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              SignUpButton(
                text: "Register",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                      RegisterWithEmailAndPasswordPressed(email: email, password: password),
                    );
                  } else {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                      RegisterWithEmailAndPasswordPressed(email: null, password: null),
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              SignUpButton(
                text: "Sign In",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                      SignInWithEmailAndPasswordPressed(email: email, password: password),
                    );
                  } else {
                    BlocProvider.of<SignUpFormBloc>(context).add(
                      SignInWithEmailAndPasswordPressed(email: null, password: null),
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              if (state.isSubmitting)
                LinearProgressIndicator(
                  minHeight: 2,
                  color: themeData.colorScheme.secondary,
                )
              else
                const SizedBox(
                  height: 2,
                ),
            ],
          ),
        );
      },
    );
  }
}
