// ignore: file_names
class AllocationsModel {
  String allocation;
  String guard;
  String uuid;
  String startTime;
  String endTime;

  AllocationsModel(
      {required this.allocation,
      required this.guard,
      required this.startTime,
      required this.endTime,
      required this.uuid});

  factory AllocationsModel.fromMap(String key, Map<dynamic, dynamic> map) {
    return AllocationsModel(
      allocation: map['Allocated_Location'] ?? '',
      guard: map['Guard_Name'] ?? '',
      uuid: map['uuid'] ?? '',
      startTime: map['Time-Start'] ?? '',
      endTime: map['EndTime'] ?? '',
    );
  }
}
