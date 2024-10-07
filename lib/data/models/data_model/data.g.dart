// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      taskList: (json['taskList'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'taskList': instance.taskList,
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      taskTitle: json['taskTitle'] as String?,
      createdDate: json['createdDate'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'taskTitle': instance.taskTitle,
      'createdDate': instance.createdDate,
      'status': instance.status,
    };
