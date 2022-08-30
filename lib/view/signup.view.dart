import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_portfolio/view/login_form.view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  void registerUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("email", _emailController.text.toString());
    sharedPreferences.setString("name", _nameController.text.toString());
    sharedPreferences.setString("phone", _phoneController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              //Image Section
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Image.asset(
                    "assets/login.png",
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.maxFinite,
                  ),
                ),
              ),
              //heading section
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),

                    //Text form field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontWeight: FontWeight.w200),
                      decoration: InputDecoration(
                        hintText: "Email Id",
                        hintStyle: const TextStyle(fontWeight: FontWeight.w200),
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //Text form field
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Full name",
                        prefixIcon: Icon(Icons.account_circle_outlined,
                            color: Colors.grey.shade400),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //Text form field
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Mobile",
                        prefixIcon:
                            Icon(Icons.phone, color: Colors.grey.shade400),
                      ),
                    ),

                    const SizedBox(height: 20),

                    RichText(
                      text: const TextSpan(
                        text: "By signing up, you're agree to our",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: " Terms & Conditions",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " and",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: " Privacy Policy",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    //register button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        minimumSize: const Size(340, 48),
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                      ),
                      onPressed: () {
                        if (_emailController.text.isNotEmpty) {
                          registerUser();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Account Created Successfully"),
                            ),
                          );
                          //move to next screen
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const HomeView()),
                              (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Please Enter Valid fields"),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Joined us before ?",
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: " Login",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => const LoginView(),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
