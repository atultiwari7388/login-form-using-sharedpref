import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_portfolio/view/home.view.dart';
import 'package:login_portfolio/view/signup.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void showAndHidePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void loginUser() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    //save user data locally
    sharedPref.setString("email", _emailController.text.toString());
    sharedPref.setBool("isLogin", true);
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
                      "Login",
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
                      controller: _passController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Colors.grey.shade400),
                        suffixIcon: IconButton(
                          onPressed: () => showAndHidePass(),
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    //login button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        minimumSize: const Size(340, 48),
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                      ),
                      onPressed: () {
                        if (_emailController.text.isNotEmpty &&
                            _passController.text.isNotEmpty) {
                          loginUser();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Welcome back"),
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
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //or section
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    //google button login

                    ElevatedButton.icon(
                      icon: Image.asset("assets/google.png",
                          height: 36, width: 50),
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        minimumSize: const Size(340, 48),
                        primary: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                      ),
                      onPressed: () {},
                      label: const Text(
                        "Login with Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "New to Logistics?",
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: " Register",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) =>
                                            const SignupView(),
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
