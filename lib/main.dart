import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_app_tutorial/tinder_card.dart';
import 'card_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const String title = 'Tinder Clone';

  final theme = ThemeData(
    primarySwatch: Colors.pink,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        primary: Colors.white,
        shape: CircleBorder(),
        minimumSize: Size.square(80),
      ),
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: theme,
        home: const MyHomePage(),
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade200, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: buildCards(),
          ),
        ),
      ),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.users;

    return users.isEmpty ?
    Center(
        child: ElevatedButton(
          child: const Text('Restart'),
          onPressed: () {
            final provider = Provider.of<CardProvider>(context, listen: false);
            provider.resetUsers();
          },
        )
    ) : Stack(
      children: users
          .map((user) =>
          Column(
            children: [
              buildLogo(),
              const SizedBox(height: 16),
              Expanded(child: TinderCard(
                user: user,
                isFront: users.last == user,
              )),
              const SizedBox(height: 16),
              buildButtons(),
            ],
          )
      ).toList(),
    );
  }

  Widget buildLogo() =>
      Row(
        children: const [
          Icon(
            Icons.local_fire_department_rounded,
            color: Colors.white,
            size: 36,
          ),
          SizedBox(width: 4),
          Text(
            'Tinder',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      );


  Widget buildButtons() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton(
          child: const Icon(
              Icons.clear,
              color: Colors.red,
              size: 45),
        onPressed: () {},
      ),
      ElevatedButton(
        child: const Icon(
            Icons.star,
            color: Colors.blue,
            size: 45),
        onPressed: () {},
      ),
      ElevatedButton(
        child: const Icon(
            Icons.favorite,
            color: Colors.teal,
            size: 45),
        onPressed: () {},
      ),
    ],
  );
}
