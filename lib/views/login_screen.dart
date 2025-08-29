import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plie/views/home_screen.dart';
import '../core/components/customButton.dart';
import '../core/components/customTextField.dart';
import '../core/constants/fonts_constants.dart';
import '../viewModel/login_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String emailError = "";
  String passwordError = "";

  // if don't want to add manually credential for testing
  // @override
  // void initState() {
  //   super.initState();
  //   emailController.text = "testpracticaluser001@mailinator.com";
  //   passwordController.text = "Test@123";
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    bool isValid = true;

    final emailText = emailController.text.trim();
    if (emailText.isEmpty) {
      emailError = "Email cannot be empty";
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailText)) {
      emailError = "Please enter valid email address";
      isValid = false;
    } else {
      emailError = "";
    }

    final passwordText = passwordController.text.trim();
    if (passwordText.isEmpty) {
      passwordError = "Password cannot be empty";
      isValid = false;
    } else if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(passwordText)) {
      passwordError =
          "Password must be 8+ chars, with uppercase, lowercase, number & special char";
      isValid = false;
    } else {
      passwordError = "";
    }

    setState(() {});
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: loginState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade300,
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pliē",
                            style: AppTextStyles.robotoRegular.copyWith(
                                fontSize: 48, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 30),
                        Image.asset(
                          "assets/images/gellery_icon.png",
                          width: 64,
                          height: 64,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email
                        CustomTextField(
                          label: "Email",
                          hint: "email@email.com",
                          controller: emailController,
                          onTextChange: () {
                            final emailText = emailController.text.trim();
                            if (emailText.isEmpty) {
                              emailError = "Email cannot be empty";
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(emailText)) {
                              emailError = "Please enter valid email address";
                            } else {
                              emailError = "";
                            }
                            setState(() {});
                          },
                        ),
                        if (emailError.isNotEmpty)
                          Text(
                            emailError,
                            style: AppTextStyles.robotoRegular
                                .copyWith(color: Colors.red, fontSize: 12),
                          ),

                        const SizedBox(height: 20),

                        // Password
                        CustomTextField(
                          label: "Password",
                          hint: "Password",
                          isPasswordField: true,
                          controller: passwordController,
                          onTextChange: () {
                            final passwordText = passwordController.text.trim();
                            if (passwordText.isEmpty) {
                              passwordError = "Password cannot be empty";
                            } else if (!RegExp(
                                    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                                .hasMatch(passwordText)) {
                              passwordError =
                                  "Password must be 8+ chars, include upper, lower, number & special char";
                            } else {
                              passwordError = "";
                            }
                            setState(() {});
                          },
                        ),
                        if (passwordError.isNotEmpty)
                          Text(
                            passwordError,
                            style: AppTextStyles.robotoRegular
                                .copyWith(color: Colors.red, fontSize: 12),
                          ),

                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Forgot Password?"),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Sign In
                        CustomButton(
                          text: "Sign In",
                          onPressed: () async {
                            final valid = _validateFields();
                            if (!valid) return;

                            await loginNotifier.login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            final resp = ref.read(loginProvider).authResponse;
                            if (resp?.success == true) {
                              if (mounted) {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        HomeScreen(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }
                            } else {
                              final msg =
                                  resp?.message ?? "Login failed. Try again.";
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(msg)),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Not a member?",
                                style: AppTextStyles.robotoRegular.copyWith(
                                  color: const Color(0xFF000000),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Sign Up Here",
                                  style: AppTextStyles.robotoRegular.copyWith(
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(child: const Divider(height: 40, thickness: 1)),
                            Text("or Sign In with:"),
                            Expanded(child: const Divider(height: 40,endIndent: 20, thickness: 1)),
                          ],
                        ),
                        Row(
                          spacing: 30,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                print("Google tap");
                              },
                              child: Image.asset("assets/images/google.png",height: 40,width: 40,),
                            ),
                            InkWell(
                              onTap: (){
                                print("Apple tap");
                              },
                              child: Image.asset("assets/images/apple-logo.png",height: 40,width: 40,),
                            ),
                            InkWell(
                              onTap: (){
                                print("Facebook tap");
                              },
                              child: Image.asset("assets/images/facebook.png",height: 40,width: 40,),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Enter as Guest"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
