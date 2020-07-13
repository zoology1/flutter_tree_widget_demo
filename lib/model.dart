import 'package:meta/meta.dart';

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