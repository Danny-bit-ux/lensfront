class Category_model{
  late final int id;
  late final String name;
   List<Category_model>? subcategories=[];
  Category_model({
    required this.id,
    required this.name,
    this.subcategories,
});


   Category_model.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    name=json['name'];
    if(json['subcategories'] !=null) {
      subcategories?.clear();
      json['subcategories'].forEach((v) {
        subcategories?.add(new Category_model.fromJson(v));
      });
    }
   // List subcategories = json['subcategories'];
   // return Category_model(id: json["id"], name: json["name"], subcategories: subcategories.isNotEmpty ? subcategories.map((e) => Category_model.fromJson(e)).toList():[]);

  }
  @override
  String toString() {
    // TODO: implement toString
    return '$name, $id,$subcategories';
  }
}
class Sub_category_model{
  final int id;
  final String name;
  final List<Sub_category_model>? subcategories;
  Sub_category_model({
    required this.id,
    required this.name,
    this.subcategories,
  });
  static Sub_category_model fromJson(Map<String, dynamic> json) {
    List subcategories = json['subcategories'];
    return Sub_category_model(id: json["id"], name: json["name"], subcategories: subcategories.isNotEmpty ? subcategories.map((e) => Sub_category_model.fromJson(e)).toList():[]);

  }
  @override
  String toString() {
    // TODO: implement toString
    return '$name, $id,$subcategories';
  }
}