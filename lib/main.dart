import 'package:flutter/material.dart';
import 'package:db/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'screens/form_screen.dart';
import 'providers/transaction_provider.dart';
import 'models/transactions.dart';

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
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch:Colors.grey,
        ),
        home: const MyHomePage(title: 'Ensiklopedia Film'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//widget untuk memanggil home screen
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
