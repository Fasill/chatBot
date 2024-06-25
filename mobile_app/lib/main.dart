import 'package:chatgpt_app/pages/chat_page.dart';
import 'package:chatgpt_app/pages/home_page.dart';
import 'package:chatgpt_app/pages/login_page.dart';
import 'package:chatgpt_app/pages/sign_up_page.dart';
import 'package:chatgpt_app/providers/chat_providers.dart';
import 'package:chatgpt_app/services/alert_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatgpt_app/firebase_options.dart';
import 'package:chatgpt_app/services/auth_service.dart';
import 'package:provider/provider.dart';


class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => const LogInPage(),
    "/sign": (context) => const SignUpPage(),
    "/chat": (context) => const ChatPage(),
    "/home": (context) => const HomePage(),
  };

  GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  void pushName(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> setup() async {
  await setupFirebase();
  await registerServices();
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<NavigationService>(NavigationService());
   getIt.registerSingleton<AlertServices>(AlertServices());
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;
  late final NavigationService _navigationService;
  late final AuthService _authService;

  MyApp({super.key}) {
    _navigationService = _getIt<NavigationService>();
    _authService = _getIt<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    String initialRoute = _authService.user != null ? "/chat" : "/login";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigationService.navigatorKey,
      title: 'ChatGPT App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: _navigationService.routes,
    );
  }
}
