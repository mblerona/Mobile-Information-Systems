import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login.dart';
const Color screenBg = Color(0xFF803636);
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  bool isValidEmail(String email){
    RegExp emailRegex = RegExp(
        "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})",
        caseSensitive: false
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBg,
      appBar: AppBar(elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Register", style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // ------------------- FORM CARD -------------------
              Card(elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(padding: const EdgeInsets.all(20),
                  child: Form(key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // NAME
                        TextFormField(controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "Enter Name",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.person, color: screenBg),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:screenBg),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // EMAIL
                        TextFormField(controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter Email",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),
                            prefixIcon: Icon(Icons.email, color: screenBg),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: screenBg),
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

                        const SizedBox(height: 20),

                        // PASSWORD
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter Password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.lock, color: screenBg),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: screenBg),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                  color: screenBg,
                                ),
                                onPressed: (){
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                }
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

                        // PHONE
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            hintText: "Enter Phone",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.phone, color:screenBg),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: screenBg),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // SIGN IN LINK
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const LoginPage()),
                            );
                          },
                          child: Text("Already have an account? Sign In!",
                            style: TextStyle(color:screenBg),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // REGISTER BUTTON
                        SizedBox(width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: screenBg,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text("Register", style: TextStyle(fontSize: 16, color:Colors.white)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final error = await AuthService().register(
                                  emailController.text,
                                  passwordController.text,
                                  context,
                                );

                                if (!mounted) return;

                                if (error != null) {
                                  // ERROR → show snackbar
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(error)));
                                } else {
                                  // SUCCESS → go to login
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Registration successful!')),
                                  );

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LoginPage()),
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
