import 'package:final_exam/constants/gaps.dart';
import 'package:final_exam/constants/sizes.dart';
import 'package:final_exam/features/authentication/view_models/social_auth_vm.dart';
import 'package:final_exam/features/authentication/views/login_form_screen.dart';
import 'package:final_exam/features/authentication/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  static String routeName = "login";
  static String routeURL = "/login";
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
        child: Column(
          children: [
            Gaps.v80,
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v20,
            const Text(
              "Create a profile, see what you could get",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.v40,
            GestureDetector(
              onTap: () => _onEmailLoginTap(context),
              child: const AuthButton(
                icon: FaIcon(FontAwesomeIcons.user),
                text: "Use email & password",
              ),
            ),
            Gaps.v16,
            GestureDetector(
              onTap: () => ref.read(socialAuthProvider.notifier).githubSingIn(),
              child: const AuthButton(
                icon: FaIcon(FontAwesomeIcons.github),
                text: "Continue with Github",
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
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
