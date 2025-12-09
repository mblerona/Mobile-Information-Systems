import 'package:flutter/material.dart';

import '../services/auth_service.dart';


const Color screenBg = Color(0xFF803636);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(
      "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})",
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFEF8F5),
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // ------------------- FORM CARD -------------------
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // EMAIL
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.red.shade400,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red.shade400,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!isValidEmail(value)) {
                              return 'Email not valid!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        TextFormField(
                          controller: passwordController,
                          obscureText: _isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter Password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.lock, color: Colors.red.shade400),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red.shade400),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password should not have less than 6 characters.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // LOGIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: screenBg,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text("Login", style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            )
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final error = await AuthService().login(
                                  emailController.text,
                                  passwordController.text,
                                  context,
                                );

                                if (!mounted) return;

                                if (error != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(error)));
                                } else {

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Login successful!')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please fill all fields')),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
