import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:park_finder/pages/get_start.dart';
import 'package:park_finder/pages/user-land_owner.dart';
import 'package:park_finder/pages/user_login.dart';
import 'package:park_finder/pages/user_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: "/GetStartedScreen",
  routes: <RouteBase>[
    GoRoute(
      name: "/UserLandOwner",
      path: "/UserLandOwner",
      builder: (context, state){
        return UserLandOwner();
      },
      ),
    GoRoute(
      name: "/RegistrationForm",
      path: "/RegistrationForm",
      builder: (context, state){
        return GetStartedScreen();
      },
      ),
      GoRoute(
      name: "/SignInScreen",
      path: "/SignInScreen",
      builder: (context, state){
        return SignInScreen();
      },
      ),
  ],
  );

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
