import 'package:backspace/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: FirebaseOptions(
    apiKey: 'AIzaSyC2zx8SZC3Wkx1Be5qkMGKrKFAd80xWLac', appId: '1:612561784678:android:cda9c04f41ca10901582a7', messagingSenderId: '612561784678', projectId: 'backspace-63c41'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    // MultiProvider(
    // providers: [
    //     ChangeNotifierProvider(create: (_) => OTPVerificationErrorProvider()), // Provide your Provider here
    //     // Add more providers if needed
    //   ],
      // child:
      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:
      // Homescreen(),
      // Success(),
      // OTPScreen(verificationId: '', value: '',),
      PhoneAuth(),
      // ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});


//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
      
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
        
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
