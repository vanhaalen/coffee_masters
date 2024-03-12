import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/pages/menupage.dart';
import 'package:coffee_masters/pages/offerspage.dart';
import 'package:coffee_masters/pages/orderpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Greet extends StatefulWidget {
  const Greet({super.key});

  @override
  State<Greet> createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  // State variable
  var name = "";

  @override
  Widget build(BuildContext context) {
    var greetStyle = const TextStyle(fontSize: 24);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            "Hello, $name!",
            style: greetStyle,
          ),
          TextField(
              onChanged: (value) => setState(() {
                    name = value;
                  })),
        ],
      ),
    );
  }
}

class HelloWorld extends StatelessWidget {
  const HelloWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Hi there!");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Masters',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage;

    switch (selectedIndex) {
      case 0:
        currentWidgetPage = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentWidgetPage = const OffersPage();
        break;
      case 2:
        currentWidgetPage = OrderPage(
          dataManager: dataManager,
        );
        break;
      default:
        currentWidgetPage = const Text("Unknown page");
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.secondary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Image.asset("images/logo.png"),
        centerTitle: true,
      ),
      body: currentWidgetPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(label: "Menu", icon: Icon(Icons.coffee)),
          BottomNavigationBarItem(
              label: "Offers", icon: Icon(Icons.local_offer)),
          BottomNavigationBarItem(
              label: "Order", icon: Icon(Icons.shopping_cart)),
        ],
      ),
    );
  }
}
