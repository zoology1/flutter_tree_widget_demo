# flutter tree widget Demo

Flutter tree widget demo application.

## Screenshot
<p>
	<img src="https://i.postimg.cc/4NNrZ54D/image1.jpg" width="250" height="443"  />
	<img src="https://i.postimg.cc/ZK7XqdCC/image2.jpg" width="250" height="443"  />
	<img src="https://i.postimg.cc/L8Jwg81v/image3.jpg" width="250" height="443"  />
</p>


## Getting Started

1. As tree widget uses GFAccordion, include getwidget in pubspec.yaml :

````
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.3
  getwidget: ^1.1.0
````

2. define your model class:
````
class Category {
  final String name;
  final int id;
  bool value;
  String comment;
  final List<Category> children;

  Category({
    @required this.name,
    @required this.id,
    this.value = false,
    this.children,
  });
}
````
3. convert your model class to TreeNode class:
````
List<TreeNode> treeNodes = _categoryList.map((item) => TreeNode.cloneCategory(item)).toList();
````
4. define nodeClicked callback funtion:
````
void nodeClicked(dynamic val, TreeNode treeNode){
    print(treeNode.name);
}
````
5. create TreeWidget:
````
child: TreeWidget(nodeList: treeNodes, nodeClicked: nodeClicked,),
````