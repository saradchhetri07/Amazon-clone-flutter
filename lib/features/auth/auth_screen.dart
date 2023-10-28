import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textField.dart';
import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum Auth { signIn, signUp }

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  Future<void> signUpUser() async {
    await authService.signUpUser(
        context: context,
        email: _emailController.text,
        username: _nameController.text,
        password: _passwordController.text);
  }

  Future<void> signInUser() async {
    await authService.signInUser(
        ctx: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              tileColor: _auth == Auth.signUp
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                groupValue: _auth,
                value: Auth.signUp,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            if (_auth == Auth.signUp)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        customHintText: "Name",
                        custom_controller: _nameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        customHintText: "Email",
                        custom_controller: _emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        customHintText: "Password",
                        custom_controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          customText: "Sign Up",
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              // signUpUser();
                            }
                          })
                    ],
                  ),
                ),
              ),

            ListTile(
              tileColor: _auth == Auth.signIn
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Sign In.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                groupValue: _auth,
                value: Auth.signIn,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signIn)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        customHintText: "Email",
                        custom_controller: _emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        customHintText: "Password",
                        custom_controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          customText: "Sign In",
                          onTap: () {
                            signInUser();
                          })
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
