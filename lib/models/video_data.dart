import 'package:json_annotation/json_annotation.dart';

part 'video_data.g.dart';

@JsonSerializable()
class VData {
  final String video;
  VData(this.video);
  factory VData.fromJson(Map<String, dynamic> json) => _$VDataFromJson(json);
}
