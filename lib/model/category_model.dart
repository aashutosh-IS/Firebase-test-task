class CategoryModel {
  final String name;
  final List<SubcategoryModel>?subcategories;

  CategoryModel({
    required this.name,
     this.subcategories=const [],
  });

  @override
  String toString() => 'CategoryModel(name: $name)';
}
class SubcategoryModel {
  final String name;
  final String description;

  SubcategoryModel({
    required this.name,
    required this.description,
  });

  @override
  String toString() => 'SubcategoryModel(name: $name, description: $description)';
}
