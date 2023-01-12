import 'package:flutter/material.dart';
import 'linear_lights_out.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linear Lights Out',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Linear Lights Out'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var game = LinearLightsOutGame();
  var preset = 0;
  String get gameStateString {
    switch (game.state) {
      case GameStatus.ongoing:
        return "Turn off all the lights";
      case GameStatus.ingame:
        return "You've made ${game.numMoves} moves";
      case GameStatus.ended:
        return "You won in ${game.numMoves} moves";
    }
  }

  @override
  Widget build(BuildContext context) {
    final lights = <Widget>[];
    if (preset == 0) {
      game.presetDetermine();
      preset = 1;
    }
    for (var k = 0; k < 7; k++) {
      var filename = "black.png";
      if (game.board[k] == LightsStatus.on) {
        filename = "light_on.png";
      } else if (game.board[k] == LightsStatus.off) {
        filename = "light_off.png";
      }
      lights.add(InkWell(
        onTap: () {
          setState(() {
            game.pressedLight(k);
          });
        },
        child: Image.asset("images/$filename"),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              this.gameStateString,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Center(
              child: Container(
                height: 40,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500.0),
                child: Stack(
                  children: [
                    GridView.count(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      crossAxisCount: 7,
                      children: lights,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0)),
                        onPressed: () {
                          setState(() {
                            game = LinearLightsOutGame();
                            this.preset = 0;
                          });
                        },
                        child: const Text(
                          "New Game",
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
