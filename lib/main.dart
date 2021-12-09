import 'package:flutter/material.dart';
import 'package:food_app/app/routes/app.routes.dart';
import 'package:food_app/presentation/View/SignIn/components/signin_authprovider.dart';
import 'package:food_app/presentation/View/SignUp/components/signup_authprovider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupAuthProvider()),
        ChangeNotifierProvider(create: (context) => SignInAuthProvider()),
      ],
      child: MaterialApp(
        title: 'Food App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/welcome",
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
