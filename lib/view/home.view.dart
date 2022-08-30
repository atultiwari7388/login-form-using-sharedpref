import 'package:flutter/material.dart';
import 'package:login_portfolio/view/signup.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String email = "";
  String name = "";
  String phone = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    email = sharedPreferences.getString("email") ?? "";
    name = sharedPreferences.getString("name") ?? "";
    phone = sharedPreferences.getString("phone") ?? "";

    setState(() {});
  }

  void logoutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => const SignupView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to Logout"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "No",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () => logoutUser(),
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Email : "),
                Text(
                  email.toString(),
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Name : "),
                Text(
                  name.toString(),
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("phone : "),
                Text(
                  phone.toString(),
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
