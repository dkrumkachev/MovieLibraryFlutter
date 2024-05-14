import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../services/AuthService.dart';
import '../services/UserService.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onClick;

  const RegisterPage({
    super.key,
    required this.onClick
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> singUp() async{
    final authService = AuthService();
    if (emailController.text.isEmpty) {
      showErrorMessage("Please enter your email.");
      return;
    }
    if (passwordController.text.isEmpty) {
      showErrorMessage("Please enter your password.");
      return;
    }
    if (passwordController.text.length < 8) {
      showErrorMessage("Password must be at least 8 characters long");
      return;
    }
    bool success = await authService.signUp(emailController.text, passwordController.text);
    if (!success){
      showErrorMessage("Failed to create an account.");
      return;
    }
    UserService userService = UserService();
    userService.createUser(emailController.text);
  }

  void showErrorMessage(String message) {
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
        )
    );
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
                    "Sign up",
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
                          await singUp();
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
                          "Already have an account? ",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 18
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onClick,
                          child: Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              )
                          ),
                        )
                      ],
                    )
                ),

              ],
            )
        )
    );
  }
}