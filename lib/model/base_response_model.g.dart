// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel _$BaseResponseModelFromJson(Map<String, dynamic> json) =>
    BaseResponseModel(
      status: json['status'] as int?,
      statusMessage: json['statusMessage'] as String?,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$BaseResponseModelToJson(BaseResponseModel instance) =>
    <String, dynamic>{
      'statusMessage': instance.statusMessage,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
