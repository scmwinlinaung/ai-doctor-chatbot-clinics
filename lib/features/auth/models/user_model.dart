import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: "_id") @Default("") String id,
    @Default("") String username,
    @Default("") String phoneno,
    @Default("") String role,
    @Default("") String password,
    @Default("") String region,
    @Default("") String city,
    DateTime? createdAt,
    int? version,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
