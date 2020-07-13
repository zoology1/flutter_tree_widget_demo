import 'package:flutter/material.dart';
import 'package:fluttertreewidgettest/tree_widget.dart';
import 'package:fluttertreewidgettest/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tree Widget Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Tree Widget Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Category> _categoryList = [
  Category(name: 'R', id :0, children: [
    Category(name: 'A', id: 1, children: [
      Category(name: 'A-A', id: 2, children: [
        Category(name: 'A-A-1', id: 3, children: [
          Category(name: 'A-A-1-1', id: 4, ),
          Category(name: 'A-A-1-2', id: 5, ),
          Category(name: 'A-A-1-3', id: 6, ),
        ]),
        Category(name: 'A-A-2', id: 7, children: [
          Category(name: 'A-A-2-1', id: 8, ),
          Category(name: 'A-A-2-2', id: 9, ),
        ]),
      ]),
      Category(name: 'A-B', id: 10, children: [
        Category(name: 'A-B-1', id: 11, ),
        Category(name: 'A-B-2', id: 12, ),
        Category(name: 'A-B-3', id: 13, ),
        Category(name: 'A-B-4', id: 14, ),
      ]),
      Category(name: 'A-C', id: 15, children: [
        Category(name: 'A-C-1', id: 16, ),
        Category(name: 'A-C-2', id: 17, ),
        Category(name: 'A-C-3', id: 18, ),
        Category(name: 'A-C-4', id: 19, ),
      ]),
      Category(name: 'A-D', id: 20, children: [
        Category(name: 'A-D-1', id: 21, ),
      ]),
      Category(name: 'A-E', id: 22, ),
      Category(name: 'A-F', id: 23, ),
      Category(name: 'A-G', id: 24, ),
    ]),
    Category(name: 'B', id: 25, children: [
      Category(name: 'B-A', id: 26, children: [
        Category(name: 'B-A-1', id: 27, children: [
          Category(name: 'B-A-1-1', id: 28, ),
          Category(name: 'B-A-1-2', id: 29, ),
          Category(name: 'B-A-1-3', id: 30, ),
        ]),
        Category(name: 'B-A-2', id: 31, children: [
          Category(name: 'B-A-2-1', id: 32, ),
          Category(name: 'B-A-2-2', id: 33, ),
        ]),
      ]),
      Category(name: 'B-B', id: 34, children: [
        Category(name: 'B-B-1', id: 35, ),
        Category(name: 'B-B-2', id: 36, ),
        Category(name: 'B-B-3', id: 37, ),
        Category(name: 'B-B-4', id: 38, ),
      ]),
      Category(name: 'B-C', id: 39, children: [
        Category(name: 'B-C-1', id: 40, ),
        Category(name: 'B-C-2', id: 41, ),
        Category(name: 'B-C-3', id: 42, ),
        Category(name: 'B-C-4', id: 43, ),
      ]),
      Category(name: 'B-D', id: 44, children: [
        Category(name: 'B-D-1', id: 45, ),
      ]),
      Category(name: 'B-E', id: 46, ),
      Category(name: 'B-F', id: 47, ),
      Category(name: 'B-G', id: 48, ),
    ]),
    Category(name: 'C', id: 49, ),
    Category(name: 'D', id: 50, ),
    Category(name: 'E', id: 51, ),
    Category(name: 'F', id: 52, ),
  ]),
  Category(name: 'R-leaf1', id: 200, ),
  Category(name: 'R-leaf2', id: 201, ),
  Category(name: 'R-leaf3', id: 202, ),
];

class _MyHomePageState extends State<MyHomePage> {
  //Convert List<Category> to List<TreeNode>
  List<TreeNode> treeNodes = _categoryList.map((item) => TreeNode.cloneCategory(item)).toList();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: TreeWidget(nodeList: treeNodes, nodeClicked: nodeClicked,),
      ),
    );
  }

  void nodeClicked(dynamic val, TreeNode treeNode){
    print(treeNode.name);
  }
}
