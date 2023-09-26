import 'dart:async';

import 'package:final_exam/features/authentication/repos/authentication_repo.dart';
import 'package:final_exam/features/users/view_models/user_vm.dart';
import 'package:final_exam/home/home_page.dart';
import 'package:final_exam/router.dart';
import 'package:final_exam/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    //initializing
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context, GoRouter router) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);

    bool success = false;
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );
      await users.createProfile(userCredential);
      success = true;
    });
    if (state.hasError) {
      showFirebaseErrorSnack(state.error);
    } else if (success) {
      goRouter.goNamed(MyHomePage.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
