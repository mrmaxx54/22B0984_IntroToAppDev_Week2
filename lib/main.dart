import 'package:budget_tracker2/screens/add_expense_popup.dart';
import 'package:budget_tracker2/screens/home_screen.dart';
import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    }
));