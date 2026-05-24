import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_notification_model.freezed.dart';
part 'clinic_notification_model.g.dart';

@freezed
class ClinicNotificationModel with _$ClinicNotificationModel {
  const factory ClinicNotificationModel({
    @JsonKey(name: '_id', fromJson: _idFromJson) String? id,
    @JsonKey(fromJson: _idFromJson) String? recipientClinic,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    @JsonKey(fromJson: _dateFromJson) String? createdAt,
    @JsonKey(fromJson: _idFromJson) String? booking,
  }) = _ClinicNotificationModel;

  factory ClinicNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicNotificationModelFromJson(json);
}

String? _idFromJson(dynamic json) {
  if (json is Map && json.containsKey('\$oid')) {
    return json['\$oid'] as String?;
  }
  return json?.toString();
}

String? _dateFromJson(dynamic json) {
  if (json is Map && json.containsKey('\$date')) {
    return json['\$date'] as String?;
  }
  return json?.toString();
}
