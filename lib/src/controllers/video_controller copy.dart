// import 'dart:developer';
// import 'dart:io';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:chewie/chewie.dart';
// import 'package:dio/dio.dart';
// import 'package:get/state_manager.dart';
// import 'package:native_video_view/native_video_view.dart';
// import 'package:videoplayerm360ict/src/models/video_model.dart';
// import 'package:videoplayerm360ict/src/services/api_services.dart';
// import 'package:dio/dio.dart' as dio;

// // ignore: depend_on_referenced_packages
// import 'package:path_provider/path_provider.dart';

// class VideoController extends GetxController with ApiServices {
//   final isLoading = RxBool(false);
//   final selectedIndex = RxInt(0);
//   final downloadProgress = RxDouble(0);
//   final isInitialize = RxBool(false);
//   final allVideoList = RxList<VideoModel>([]);
//   final isVideoStuck = RxBool(false);
//   final videoDuration = RxInt(0);
//   ChewieController? chewieController;
//   late VideoViewController videoPlayerController;
//   @override
//   void onInit() {
//     getAllVideos();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     videoPlayerController.dispose();
//     chewieController!.dispose();
//     super.onClose();
//   }

//   // Future<void> initializePlayerC(String url) async {
//   //   videoPlayerController = VideoPlayerController.network(url)
//   //     ..videoPlayerOptions;

//   //   await Future.wait([videoPlayerController.initialize()]).then((value) {
//   //     isInitialize.value = true;
//   //   });

//   //   chewieController = ChewieController(
//   //       allowFullScreen: true,
//   //       videoPlayerController: videoPlayerController,
//   //       autoPlay: false,
//   //       looping: false,
//   //       materialProgressColors: ChewieProgressColors(
//   //           playedColor: Colors.red,
//   //           handleColor: Colors.cyanAccent,
//   //           backgroundColor: Colors.yellow,
//   //           bufferedColor: Colors.lightGreen),
//   //       placeholder: Container(
//   //         color: Colors.greenAccent,
//   //       ),
//   //       autoInitialize: true);
//   // }
//   Future<bool> saveVideo(String url, String fileName) async {
//     Directory directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = (await getExternalStorageDirectory())!;
//           String newPath = "";

//           List<String> paths = directory.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/$folder";
//             } else {
//               break;
//             }
//           }
//           newPath = "$newPath/VidepApp";
//           directory = Directory(newPath);
//         } else {
//           return false;
//         }
//       } else {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getTemporaryDirectory();
//         } else {
//           return false;
//         }
//       }
//       File saveFile = File("${directory.path}/$fileName");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         await Dio().download(url, saveFile.path,
//             onReceiveProgress: (value1, value2) {
//           downloadProgress.value = value1 / value2;
//           log(downloadProgress.value.toString());
//         });

//         return true;
//       }
//       return false;
//     } catch (e) {
     
//       return false;
//     }
//   }

//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result =  await Permission.storage.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }

//   downloadFile({required String url}) async {
//     String fileName = 'newVideo';
//     bool downloaded = await saveVideo(url, fileName);
//     if (downloaded) {
//      // print("File Downloaded");
//     } else {
//       //print("Problem Downloading File");
//     }
//   }

//   void showDownloadProgress(received, total) {
//     if (total != -1) {
//      //print((received / total * 100).toStringAsFixed(0) + "%");
//       downloadProgress.value = (received / total * 100);
//     }
//   }

//   getAllVideos() async {
//     try {
//       isLoading.value = true;

//       final res = await getDynamic(
//         path:
//             'https://hajjmanagment.online/api/external/atab/m360ict/get/video/app/test',
//       );
//       if (res.data['success'] == true) {
//         final a = res.data['data']
//             .map((json) => VideoModel.fromJson(json as Map<String, dynamic>))
//             .toList()
//             .cast<VideoModel>() as List<VideoModel>;
//         allVideoList.addAll(a);

//         isLoading.value = false;
//         log(a.length.toString());
//       }

//       //  offAll(ProjectDashboardv1());
//     } on dio.DioError catch (e) {
//       isLoading.value = false;
//       log(e.message);
//     }
//   }
// }
