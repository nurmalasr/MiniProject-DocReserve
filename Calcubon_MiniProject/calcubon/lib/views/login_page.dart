import '../utils/colors.dart';
import '../views/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userCtrl = TextEditingController();
    var passCtrl = TextEditingController();
    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
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
          Center(
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
                  TextField(
                    controller: userCtrl,
                    cursorColor: primaryColor,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people,
                        color: primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: primaryColor),
                    ),
                  ),
                  TextField(
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
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(primaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
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
        ],
      ),
    );
  }
}
