import 'package:calcubon/blocs/user/user_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailCtrl = TextEditingController();
    var passCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              top: 16.0,
            ),
            child: Text(
              'Calcubon',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Center(
                child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              margin: const EdgeInsets.all(30),
              child: Container(
                width: MediaQuery.of(context).size.width * 1.5,
                height: MediaQuery.of(context).size.width * 1.5,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailCtrl,
                      cursorColor: primaryColor,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.people,
                          color: primaryColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email wajib diisi';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passCtrl,
                      obscureText: true,
                      cursorColor: primaryColor,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.key,
                          color: primaryColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Password wajib diisi';
                        } else if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(primaryColor),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                                SignIn(
                                  email: emailCtrl.text,
                                  password: passCtrl.text,
                                ),
                              );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
