
class Group {
  String id;
  String name;
  String image;
  String description;
  List<String> teachers;
  String createdBy;

  Group({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.teachers,
    required this.createdBy,
  });
}