import 'dart:convert';
import 'package:flutter/material.dart';

const colors = [
  Colors.yellow,
  Colors.blue,
  Colors.pink,
  Colors.lightGreen,
];

var temp = 5 % 10;

final Map keymap = {};

class Test extends StatefulWidget {
  final dynamic data;
  final int depth;
  final String kee;

  Test({
    Key? key,
    required this.data,
    required this.depth,
    required this.kee,
  }) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

void _getPositions2(GlobalKey<State<StatefulWidget>> _key) {
  final renderObject = _key.currentContext?.findRenderObject();
  var translation = renderObject?.getTransformTo(null).getTranslation();
  if (translation != null && renderObject?.paintBounds != null) {
    final temp = renderObject?.paintBounds.shift(Offset(translation.x, translation.y));
    print(keymap);
    if (temp != null) {
      print('TOP: ${temp.top}');
      print('bottom: ${temp.bottom}');
      print('left: ${temp.left}');
      print('right: ${temp.right}');
    }
  } else {
    print('no position');
  }
}

class _TestState extends State<Test> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.depth == 1) {
      keymap[widget.kee] = _key;
    }
  }

  _getPositions() {
    final renderObject = _key.currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final temp = renderObject?.paintBounds.shift(Offset(translation.x, translation.y));
      print(keymap);
      if (temp != null) {
        print('TOP: ${temp.top}');
        print('bottom: ${temp.bottom}');
        print('left: ${temp.left}');
        print('right: ${temp.right}');
      }

      if (keymap[widget.kee] != null) {
        _getPositions2(keymap[widget.kee]);
      } else {}
    } else {
      print('no position');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data is String ||
        widget.data is double ||
        widget.data is int ||
        widget.data is bool) {
      return GestureDetector(
        key: widget.kee == 'type' ? _key : null,
        onTap: widget.kee == 'type' ? _getPositions : null,
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Container(
                child: Text(widget.kee),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: colors[widget.depth % colors.length][100],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colors[widget.depth % colors.length][100],
                  ),
                  child: Text('${widget.data}'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.data is List) {
      final temp = widget.data as List;

      return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors[widget.depth % colors.length][100],
        ),
        child: ExpansionTile(
          maintainState: true,
          expandedAlignment: Alignment.topLeft,
          title: Text(widget.kee),
          children: [
            Container(
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: temp.map((el) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: colors[(widget.depth + 1) % colors.length][100],
                    ),
                    child: Text(el),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }

    if (widget.data is Map && widget.data.containsKey('type') && widget.data['type'] is String) {
      final temp = widget.data as Map;

      final params = temp.keys.map((kee) {
        return Test(
          depth: widget.depth + 1,
          kee: kee,
          data: temp[kee],
        );
      }).toList();

      return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors[widget.depth % colors.length][100],
        ),
        child: Column(
          children: [Text(widget.kee), ...params],
        ),
      );
    }

    if (widget.data is Map) {
      final temp = widget.data as Map;

      return GestureDetector(
        key: _key,
        onTap: _getPositions,
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors[widget.depth % colors.length][100],
          ),
          child: ExpansionTile(
            maintainState: true,
            title: Text(widget.kee),
            children: temp.keys.map((kee) {
              return Test(
                depth: widget.depth + 1,
                kee: kee,
                data: temp[kee],
              );
            }).toList(),
          ),
        ),
      );
    }

    return Container();
  }
}

void logObject(dynamic arg) {
  if (arg is Map) {
    print('--- OBJECT --- === $arg');
    for (var kee in arg.keys) {
      logObject(arg[kee]);
    }
  } else if (arg is List) {
    print('--- ARRAY --- === $arg');
    arg.forEach((element) {
      logObject(element);
    });
  } else if (arg is String) {
    print('--- STRING --- === $arg');
  } else if (arg is double || arg is int) {
    print('--- NUMBER --- === $arg');
  }
}

void parseJson(String raw) {
  final Map<String, dynamic> object = json.decode(raw) as Map<String, dynamic>;

  List<String> global = [];

  void addGlobalType(String str) {
    global.add(str);
  }

  void addGlobalEnums(String str) {
    global.add(str);
  }

  for (var kee in object.keys) {
    // print(kee);

    if (kee == 'types') {
      print(object[kee].keys);
    }

    // logObject(object[kee]);
    // print('---');
  }

  print(object);
}
