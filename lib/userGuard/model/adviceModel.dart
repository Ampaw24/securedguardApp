// ignore: file_names

class AdviceModel {
  String description;
  String title;
  String uuid;

  AdviceModel({
    required this.description,
    required this.title,
    required this.uuid,
  });

  factory AdviceModel.fromMap(String key, Map<dynamic, dynamic> map) {
    return AdviceModel(
        description: map['description'] ?? '',
        title: map['title'] ?? '',
        uuid: map['uuid'] ?? '');
  }
}
