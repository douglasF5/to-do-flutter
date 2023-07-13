import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_flutter/services/auth.dart';
import 'package:to_do_flutter/widgets/decorated_text_input.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Login({required this.auth, required this.firestore, super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 16,
                ),
                DecoratedTextInput(
                  child: TextFormField(
                    key: const ValueKey('email'),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      hintText: 'Email',
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _emailController,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DecoratedTextInput(
                  child: TextFormField(
                    key: const ValueKey('password'),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: _passwordController,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton(
                      key: const ValueKey("signIn"),
                      onPressed: () async {
                        final String retVal =
                            await Auth(auth: widget.auth).signIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (retVal == "Success") {
                          _emailController.clear();
                          _passwordController.clear();
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(retVal),
                            ));
                          }
                        }
                      },
                      child: Text("Sign In",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                    ),
                    TextButton(
                      key: const ValueKey("createAccount"),
                      onPressed: () async {
                        final String retVal =
                            await Auth(auth: widget.auth).createAccount(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (retVal == "Success") {
                          _emailController.clear();
                          _passwordController.clear();
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(retVal),
                            ));
                          }
                        }
                      },
                      child: Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
