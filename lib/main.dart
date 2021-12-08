import 'package:flutter/material.dart';
import 'package:food_app/app/routes/app.routes.dart';
import 'package:food_app/presentation/View/SignUp/components/signup_authprovider.dart';
import 'package:provider/provider.dart';

void main() {
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
