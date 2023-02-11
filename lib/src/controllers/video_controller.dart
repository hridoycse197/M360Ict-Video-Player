import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayerm360ict/src/models/video_model.dart';
import 'package:videoplayerm360ict/src/services/api_services.dart';

// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:videoplayerm360ict/src/views/dash_board.dart';

class VideoController extends GetxController with ApiServices {
  final isLoading = RxBool(false);
  final isVideoRunning = RxBool(false);
  final selectedIndex = RxInt(1);
  final videoDuration = RxInt(0);
  final downloadProgress = RxDouble(0);
  final allVideoList = RxList<VideoModel>([]);
  final isMusicOn = RxBool(false);
  final isPlayOn = RxBool(false);
  final chewieController = Rx<ChewieController?>(null);
  final controller = Rx<VideoPlayerController?>(null);
  final videoPlayerController = Rx<VideoPlayerController?>(null);
  @override
  void onInit() {
    getAllVideos();
    super.onInit();
  }

  getAllVideos() async {
    try {
      isLoading.value = true;

      final res = await getDynamic(
        path:
            'https://hajjmanagment.online/api/external/atab/m360ict/get/video/app/test',
      );
      if (res.data['success'] == true) {
        final a = res.data['data']
            .map((json) => VideoModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<VideoModel>() as List<VideoModel>;
        allVideoList.addAll(a);
        // for (var element in allVideoList) {
        //   String a = (await getApplicationDocumentsDirectory()).path;

        //   element.thumnailPath = a;

        //   print(element.thumnailPath);
        // }
        Get.to(() => DashboardScreen());
        isLoading.value = false;
        log(a.length.toString());
      }

      //  offAll(ProjectDashboardv1());
    } on dio.DioError catch (e) {
      isLoading.value = false;
      log(e.message);
    }
  }

  Future downloadFile(String url) async {
    var _dio = dio.Dio();
    try {
      if (await requestPermission()) {
        Directory dir = await getApplicationDocumentsDirectory();
        log(dir.path);

        if (await dir.exists()) {
          String saveFile = "${dir.path}/${selectedIndex.value}.mp4";
          await _dio.download(url, saveFile, onReceiveProgress: (rec, total) {
            log(((100 / total) * rec).toString());
            downloadProgress.value = ((100 / total) * rec);
            log('show data: ${downloadProgress.value}');
            print("Rec: $rec , Total: $total");
          });
        } else {
          await dir.create(recursive: true);
        }
      }
    } catch (e) {
      print(e);
    }
    print("Download completed");
  }

  Future<bool> requestPermission() async {
    final permission = Permission.storage;

    if (await permission.isGranted) {
      return true;
    } else {
      var r = await permission.request();
      if (r == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
