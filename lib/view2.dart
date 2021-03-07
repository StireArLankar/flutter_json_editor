import 'package:flutter/material.dart';
import './jsonParser.dart';

class MyTest2 extends StatelessWidget {
  const MyTest2({
    Key? key,
    required this.json,
  }) : super(key: key);

  final Map json;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello world"),
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
                  color: Colors.black38,
                  child: Table(
                    defaultColumnWidth: IntrinsicColumnWidth(),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            // decoration: BoxDecoration(
                            //   gradient: LinearGradient(
                            //     begin: Alignment.topCenter,
                            //     end: Alignment.bottomCenter,
                            //     colors: [Colors.orange, Colors.red],
                            //     stops: [0.0, 1.0],
                            //   ),
                            // ),
                            child: Column(
                              children: json.keys.map((kee) {
                                return Test(
                                  data: json[kee],
                                  kee: kee,
                                  depth: 0,
                                );
                              }).toList(),
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
}
