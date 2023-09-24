import 'package:final_exam/features/authentication/views/login_screen.dart';
import 'package:final_exam/home/home_page.dart';
import 'package:final_exam/navigator/main_navigation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
        // http://localhost:55365/ welcome
      ),
      GoRoute(
        name: MyHomePage.routeName,
        path: MyHomePage.routeURL,
        builder: (context, state) => const MyHomePage(title: 'welcome'),
        // http://localhost:55365/ welcome
      ),
      GoRoute(
        path: "/:tab(home|xxx1|xxx2|xxx3|setting)",
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.params["tab"]!;
          return MainNavigationScreen(tab: tab);
        },
        // http://localhost:55365/#/home  navihome
      ),
    ],
  );
});
