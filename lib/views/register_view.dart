import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sample/constants/routes.dart';
import 'package:sample/firebase_options.dart';
import 'package:sample/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Register'),
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
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _email.text,
                          password: _password.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          await showErrorDialog(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          await showErrorDialog(context,
                              'The account already exists for that email.');
                        } else {
                          await showErrorDialog(context, e.message ?? '');
                        }
                      } catch (e) {
                        await showErrorDialog(context, e.toString());
                      }
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, (route) => false);
                    },
                    child: const Text('Already registered? Login here!'),
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
}
