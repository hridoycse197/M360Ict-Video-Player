// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_rx/get_rx.dart';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    required this.id,
    required this.caption,
    this.isSelect,
    required this.videoUrl,
    required this.createdAt,
  });

  int id;
  RxBool? isSelect;
  String caption;
  String videoUrl;
  DateTime createdAt;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        isSelect: false.obs,
        id: json["id"],
        caption: json["caption"],
        videoUrl: json["video_url"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "caption": caption,
        "video_url": videoUrl,
        "created_at": createdAt.toIso8601String(),
      };
}
