import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabaseconnect/Loginpage.dart';

const supabaseUrl = 'https://xwopnwtxbbnpmqqfuhuy.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh3b3Bud3R4YmJucG1xcWZ1aHV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0ODgyNTIsImV4cCI6MjA1MzA2NDI1Mn0._LBXrvdXstSwRMxb_pKaKKYNy5VC_9DyX4FSfa9cnHk';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Set the LoginPage as the initial screen.
    );
  }
}
