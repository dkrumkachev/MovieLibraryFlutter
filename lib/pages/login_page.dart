import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../services/AuthService.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onClick;

  const LoginPage({
    super.key,
    required this.onClick
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async{
    final authService = AuthService();
    bool success = await authService.signIn(emailController.text, passwordController.text);
    if (!success){
      showErrorMessage("Incorrect email or password.");
      return;
    }
  }

  void showErrorMessage(String message) {
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
        )
    );
  }

  void onButtonClick() async {

  }

  @override
  Widget build(BuildContext context) {
    bool isClicked = false;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "Sign in",
                style: TextStyle(
                fontSize: 40,
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 25),
              child: CustomTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25),
              child: CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25),
              child: CustomButton(
                  onClick: () async {
                    if (!isClicked) {
                      await signIn();
                      isClicked = false;
                    }
                  },
                  text: "Sign in"
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onClick,
                    child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        )
                    ),
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }
}