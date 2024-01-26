import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Login Greeting
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Validasi login dapat ditambahkan di sini
                    String username = usernameController.text;
                    String password = passwordController.text;

                    // Contoh validasi sederhana enkripsi
                    final hashedPassword = sha256.convert(utf8.encode('admin')).toString();

                    final enteredHashPassword = sha256.convert(utf8.encode(password)).toString();

                    if (username == 'admin' && enteredHashPassword == hashedPassword) {
                      // Jika login berhasil, pindah ke halaman lain atau lakukan tindakan lainnya
                      print(enteredHashPassword);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      // Jika login gagal, tampilkan pesan kesalahan atau lakukan tindakan lainnya
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Login Gagal'),
                          content: Text('Username atau password salah.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              // Sign Up with Social Media
              Text(
                'or sign up with social media',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSocialMediaButton(
                      'assets/facebook_logo.png', 'Facebook'),
                  SizedBox(width: 20),
                  buildSocialMediaButton('assets/google_logo.png', 'Google'),
                  SizedBox(width: 20),
                  buildSocialMediaButton('assets/twitter_logo.png', 'Twitter'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSocialMediaButton(String imagePath, String socialMediaName) {
    return Column(
      children: [
        Image.asset(imagePath, height: 40, width: 40),
        SizedBox(height: 5),
        Text(socialMediaName),
      ],
    );
  }
}
