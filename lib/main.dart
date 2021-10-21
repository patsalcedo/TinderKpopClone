import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder_app_tutorial/tinder_card.dart';
import 'card_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'Tinder Clone';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: MyHomePage(),
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: buildCards(),
        ),
      ),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final assetImages = provider.assetImages;

    return assetImages.isEmpty ?
    Center(
      child: ElevatedButton(
        child: const Text('Restart'),
        onPressed: () {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.resetUsers();
        },
      )
    ) : Stack(
      children: assetImages
          .map((assetImage) => TinderCard(
                assetImage: assetImage,
                isFront: assetImages.last == assetImage,
              ))
          .toList(),
    );
  }
}
