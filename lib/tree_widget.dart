import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';

import 'package:fluttertreewidgettest/model.dart';


class TreeWidget extends StatefulWidget {

  final List<TreeNode> nodeList;
  //nodeClicked is called when checkbox of node is clicked.
  final void Function(dynamic, TreeNode) nodeClicked;

  TreeWidget({
    Key key,
    @required this.nodeList,
    @required this.nodeClicked,
  }) : super(key: key);

  @override
  TreeWidgetState createState() => TreeWidgetState();
}

class TreeWidgetState extends State<TreeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => _buildNodes(context, index),
        itemCount: widget.nodeList.length,
      ),
    );
  }

  Widget _buildNodes(BuildContext context, int index){
    // config Parent Node's value.
    widget.nodeList?.forEach((element){
      if (element.children != null) element?.configParentNodeValue();
    });
    return _TreeNodeItem(widget.nodeList[index], _nodeClicked);
  }

  void _nodeClicked(dynamic val, TreeNode treeNode){
    if(treeNode.children == null){
      treeNode.value = val;
    }else{
      if(val == null) treeNode.value = false;
      else treeNode.value = val;

      treeNode.setValue(treeNode.value);
    }

    if (treeNode.parent != null) treeNode.parent.adjustParentValue();

    setState(() {
    });

    if (widget.nodeClicked != null) widget.nodeClicked(val, treeNode);
  }
}

class _TreeNodeItem extends StatelessWidget {
  const _TreeNodeItem(this.entry, this._nodeClicked);

  final TreeNode entry;
  final void Function(dynamic, TreeNode) _nodeClicked;

  Widget _buildTiles(BuildContext context, TreeNode treeNode, TreeNode parent) {
    if (treeNode.children == null)
      return _createChildTile(context, treeNode, parent);
    return _createParentTile(context, treeNode, parent);
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(context, entry, null);
  }

  Widget _createParentTile(BuildContext context, TreeNode treeNode, TreeNode parent){
    treeNode.parent = parent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: GFAccordion(
            titlePadding: EdgeInsets.fromLTRB(0, 2, 0, 2),
            contentPadding: EdgeInsets.fromLTRB(30, 2, 0, 2),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            collapsedTitlebackgroundColor: const Color(0xFFE0E0E0),
            expandedTitlebackgroundColor: const Color(0xFFE0E0E0),
            titleChild: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Checkbox(
                  tristate: true,
                  value: treeNode.value,
                  onChanged: (val) => _nodeClicked(val, treeNode),
                ),
                Expanded(
                  child: ListTile(title: Text(treeNode.name)),
                ),
              ],
            ),
            contentChild : Column(children : treeNode.children.map((i) =>_buildTiles(context, i, treeNode)).toList()),
          ),
        ),
      ],
    );
  }

  Widget _createChildTile(BuildContext context, TreeNode treeNode, TreeNode parent){
    treeNode.parent = parent;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            tristate: false,
            value: treeNode.value,
            onChanged: (val) => _nodeClicked(val, treeNode),
          ),
          Expanded(
            child: ListTile(title: Text(treeNode.name)),
          ),
        ],
      ),
    );
  }
}

class TreeNode {
  // node name
  String name;
  // in case of node with checkbox, value is checkbox value. true = checked, false = unchecked
  bool value;
  // TreeNode id
  int id;
  TreeNode parent;
  List<TreeNode> children;

  TreeNode({
    @required this.name,
    this.value = false,
    this.children = const <TreeNode>[],
  });

  TreeNode.clone(TreeNode source) :
        this.name = source.name,
        this.id = source.id?? null,
        this.value = source.value ?? false,
        this.children = (source.children != null) ? source.children.map((item) => TreeNode.clone(item)).toList() : null;

  TreeNode.cloneCategory(Category source) :
        this.name = source.name,
        this.id = source.id ?? null,
        this.value = source.value ?? false,
        this.children = (source.children != null) ? source.children.map((item) => TreeNode.cloneCategory(item)).toList() : null;

  // set treeNode and its children value
  void setValue(bool val){
    this.value = val;
    this.children?.forEach((item) => item.setValue(val));
  }

  // if there is parent node in children, configure it's value
  void configParentNodeValue(){
    this.children?.forEach((item){
      if (item.children != null) item.configParentNodeValue();
    });

    if (this.children.every((item) => item.value == true)) this.value = true;
    else if(this.children.every((item) => item.value == false)) this.value = false;
    else this.value = null;
  }

  // Adjust parent value if child's value changed.
  void adjustParentValue(){
    if (this.children == null) return;

    bool adVal;
    if (this.children.every((item) => item.value == true)) adVal = true;
    else if(this.children.every((item) => item.value == false)) adVal = false;
    else adVal = null;

    if(this.value != adVal){
      this.value = adVal;
      if(this.parent != null) this.parent.adjustParentValue();
    }
  }

  List<int> getLeafNodeIds(){
    List<int> ids = [];
    ids = _getLeafNodeIds(ids);
    return ids;
  }

  List<int> _getLeafNodeIds(List<int> ids){
    this.children?.forEach((item){
      if (item.children != null) item._getLeafNodeIds(ids);
      else ids.add(item.id);
    });

    return ids;
  }

  List<int> getLeafNodeIdsWithValue(bool value){
    List<int> ids = [];
    ids = _getLeafNodeIdsWithValue(ids, value);
    return ids;
  }

  List<int> _getLeafNodeIdsWithValue(List<int> ids, value){
    this.children?.forEach((item){
      if (item.children != null) item._getLeafNodeIdsWithValue(ids, value);
      else if(value == item.value) ids.add(item.id);
    });

    return ids;
  }
}