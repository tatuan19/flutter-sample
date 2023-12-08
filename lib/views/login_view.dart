import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sample/firebase_options.dart';
import 'package:sample/utilities/dialogs/error_dialog.dart';
import 'package:sample/views/routes/app_router.gr.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: <Widget>[
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email.text,
                          password: _password.text,
                        );
                        context.router.replace(const WaitingRoute());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          await showErrorDialog(
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'wrong-password') {
                          await showErrorDialog(
                            context,
                            'Wrong password provided for that user.',
                          );
                        } else {
                          await showErrorDialog(
                            context,
                            'An error occurred. Error: ${e.code}',
                          );
                        }
                      } catch (e) {
                        await showErrorDialog(
                          context,
                          'An error occurred. Error: $e',
                        );
                      }
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.replace(const RegisterRoute());
                    },
                    child: const Text('Not registered yet? Register here!'),
                  ),
                ],
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
