import 'package:flutter/material.dart';
import 'package:react_popup/react_popup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Reactions Demo'),
      ),
      body: ReactionsParent(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ReactionsWrapper(
                key: UniqueKey(),
                reactionWidth: 170,
                offset: const Offset(-190, -80),
                alignment: Alignment.bottomRight,
                reactions: [
                  Reaction(
                    onSelected: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.thumb_up),
                    ),
                  ),
                  Reaction(
                    onSelected: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.thumb_down),
                    ),
                  ),
                ],
                child: Image.network(
                  'https://i0.wp.com/www.tusktravel.com/blog/wp-content/uploads/2020/04/Mumbai-Marine-Drive.jpg?fit=1024%2C685&ssl=1',
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              ReactionsWrapper(
                key: UniqueKey(),
                reactionWidth: 170,
                alignment: Alignment.topLeft,
                offset: const Offset(20, 20),
                reactions: [
                  Reaction(
                    onSelected: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.thumb_up),
                    ),
                  ),
                  Reaction(
                    onSelected: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.thumb_down),
                    ),
                  ),
                ],
                child: Image.network(
                  'https://tourscanner.com/blog/wp-content/uploads/2022/07/fun-and-unusual-things-to-do-in-Mumbai.jpg',
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              ReactionsWrapper(
                key: UniqueKey(),
                reactionWidth: 170,
                alignment: Alignment.topRight,
                offset: const Offset(-190, 20),
                overlayBackgroundColor: Colors.white60,
                reactions: [
                  Reaction(
                    onSelected: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.thumb_up),
                    ),
                  ),
                  Reaction(
                    onSelected: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.thumb_down),
                    ),
                  ),
                ],
                child: Image.network(
                  'https://www.savaari.com/blog/wp-content/uploads/2021/12/1024px-Mumbai_Aug_2018_43397784544-1024x761.jpg',
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              ReactionsWrapper(
                key: UniqueKey(),
                reactionWidth: 170,
                alignment: Alignment.bottomLeft,
                offset: const Offset(0, 20),
                reactions: [
                  Reaction(
                    onSelected: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.thumb_up),
                    ),
                  ),
                  Reaction(
                    onSelected: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.thumb_down),
                    ),
                  ),
                ],
                child: Image.network(
                  'https://tourscanner.com/blog/wp-content/uploads/2022/07/fun-and-unusual-things-to-do-in-Mumbai.jpg',
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
