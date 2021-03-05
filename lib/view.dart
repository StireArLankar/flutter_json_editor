import 'package:flutter/material.dart';

import 'section.dart';

class MyTest extends StatefulWidget {
  MyTest({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return InteractiveViewer(
                maxScale: 1,
                minScale: 1,
                constrained: false,
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: constraints.minWidth,
                    minHeight: constraints.minHeight,
                  ),
                  color: Colors.black,
                  child: Table(
                    defaultColumnWidth: IntrinsicColumnWidth(),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.orange, Colors.red],
                                stops: [0.0, 1.0],
                              ),
                            ),
                            child: Column(
                              children: [
                                newMethod(),
                                newMethod(),
                                newMethod(),
                                newMethod(),
                                newMethod(),
                                newMethod(),
                                newMethod(),
                                newMethod(),
                                newMethod(),
                                newMethod(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Container newMethod([int tick = 0]) {
    if (tick > 3) {
      return Container(
        child: ExpansionTile(
          maintainState: true,
          title: Text(
            "hello123123asd     ",
          ),
          children: [
            buildRow(),
            buildRow(),
            buildRow(),
          ],
        ),
      );
    }

    return Container(
      child: ExpansionTile(
        maintainState: true,
        onExpansionChanged: (_) => print("$tick $_"),
        title: Text(
          "hello123123asd     ",
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          newMethod2(),
          Container(
            margin: const EdgeInsets.only(left: 50),
            child: newMethod(tick + 1),
          ),
        ],
      ),
    );
  }

  Section newMethod2([int tick = 0]) => tick < 2
      ? Section(child: newMethod2(tick + 1))
      : Section(
          child: Text("hello world"),
        );

  Container buildRow() {
    return Container(
      child: Text("asd"),
      padding: EdgeInsets.all(10),
      color: Colors.black26,
      width: 300,
    );
  }
}
