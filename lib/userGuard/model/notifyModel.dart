// ignore: file_names
class Notify {
  String description;
  String title;
  String uuid;

  Notify({
    required this.description,
    required this.title,
    required this.uuid,
  });

  factory Notify.fromMap(String key, Map<dynamic, dynamic> map) {
    return Notify(
      description: map['description'] ?? '',
      title: map['title'] ?? '',
      uuid: map['uuid'] ?? '',
    );
  }
}
