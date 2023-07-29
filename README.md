# Floating Reactions Overlay

A highly customizable flutter package that helps you to easily implement actions - reactions overlay pop-up for widgets in your app. The best part: It is designed to automatically handle multiple elements of the same type and gracefully close the old - active reaction pop-up when the user taps on another widget that has reactions. Of course, you can alter this behaviour if you don't want it.

## Demo

[![Video](https://img.youtube.com/vi/htnJVyZE_kI/maxresdefault.jpg)](https://www.youtube.com/watch?v=htnJVyZE_kI)

## Getting Started

There are three widgets you need to know:

### ReactionsParent

```
ReactionsParent ReactionsParent({Key? key, required Widget child})
```

This widget will contain one or multiple `ReactionsWrapper` widgets. If Multiple `ReactionsWrapper` widgets are directly within the widget tree of this `ReactionsParent` widget, then **only one reactions pop-up will be active at one time.** Package allows for the graceful closure of other active reactions. This can be useful in a list or any view that has multiple widgets of the same type like a chat window or a feed of posts.

**Note: The Key is a required parameter and UniqueKey() can be passed here for this to perform normally.**


### ReactionsWrapper
```
ReactionsWrapper ReactionsWrapper({
  required Key? key,
  double? reactionWidth,
  Color overlayBackgroundColor = Colors.black12,
  bool showCloseButton = true,
  Widget? customCloseButton,
  Offset? offset,
  Alignment? alignment,
  required List<Reaction> reactions,
  required Widget child,
})
```

This widget is where the magic happens, wrap your widget with this and see your reactions UI pop into life. It uses the Overlay API provided by the SDK to dispay a nice looking customizable reactions UI. Don't worry about scrolling either, it automatically attaches itself to the widget so chances of anything going wrong are *near zero* ;p


### Reaction

```
Reaction Reaction({
  Key? key,
  required FutureOr<void> Function() onSelected,
  required Widget child,
})
```

Now if you noticed in the `ReactionsWrapper` widget above, there exists a parameter called `reactions`. These `reactions` takes a `List<Reaction>` widgets which can be defined here in a fairly simple way. Once tapped, the reaction overlay will close. While this behaviour can't be customized, you can add whatever you like in the child, an animation, video, image, icon.

## Example

```
import 'package:flutter/material.dart';
import 'package:reactions_demo/reactions/reactions.dart';

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

```