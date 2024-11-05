import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  int? id;
  String? title;
  List<Task>? taskList;

  Data({
    this.id,
    this.title,
    this.taskList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Task {
  int? id;
  int? dataId;
  int? notificationEnabled;
  String? taskTitle;
  String? createdDate;
  String? note;
  String? status;

  Task({
    this.id,
    this.dataId,
    this.notificationEnabled,
    this.taskTitle,
    this.createdDate,
    this.note,
    this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
