import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/repositories/authentication_repository.dart';
import 'package:univalle_app/sign_in/sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SignInHeader(),
                  BlocProvider<SignInBloc>(
                    create: (context) {
                      return SignInBloc(
                        authRepository:
                            context.read<AuthenticationRepository>(),
                      );
                    },
                    child: const SignInForm(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
