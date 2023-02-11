import 'dart:developer';
import 'package:share_plus/share_plus.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:native_video_view/native_video_view.dart';
import '../config/base.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/vertical_space_widget.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with Base {
  bool isMusicOn = false;
  VideoPlayerController? controller;
  ChewieController? chewieController;
  void soundToggle() {
    setState(() {
      isMusicOn = !isMusicOn;
      isMusicOn == false
          ? videoC.controller.value!.setVolume(0.0)
          : videoC.controller.value!.setVolume(1.0);
    });
    print(isMusicOn);
  }

  void initState() {
    super.initState();

    // _controller.setVolume(0.0);
    // _controller.setLooping(true);
    // _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    videoC.controller.value!.dispose();
    videoC.controller.value!.pause();

    isMusicOn = false;
  }

  @override
  void deactivate() {
    videoC.controller.value!.setVolume(0.0);
    super.deactivate();
  }

  playvideo() async {
    setState(() {});
    if (controller != null && controller!.value.isInitialized) {
      controller!.value != null;
      controller!.pause();
    }
    controller = VideoPlayerController.network(
        formatHint: VideoFormat.other,
        videoC.allVideoList[videoC.selectedIndex.value].videoUrl);
    await controller!.initialize();

    chewieController = ChewieController(
      videoPlayerController: controller!,
      autoPlay: true,
      looping: false,
    );
  }

  Widget playview(BuildContext context) {
    setState(() {});
    if (controller != null && controller!.value.isInitialized) {
      return Chewie(
        controller: chewieController!,
      );
    } else {
      return const Text('Video is Initializing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242730),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.center,
                  width: Get.width * .95,
                  color: Colors.white,
                  child: playview(context)
                  // Chewie(
                  //     controller: videoC.chewieController.value!,
                  //   )
                  // : const Text('Video is Initializing')),

                  //  const Icon(
                  //   Icons.play_arrow,
                  //   size: 100,
                  // ),
                  )),
          Expanded(
              flex: 4,
              child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: videoC.allVideoList.length,
                    itemBuilder: (context, index) {
                      final item = videoC.allVideoList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          height: 160,
                          width: Get.width * .8,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  log(videoC
                                      .allVideoList[videoC.selectedIndex.value]
                                      .videoUrl
                                      .toString());
                                  videoC.selectedIndex.value = index;
                                  await playvideo();
                                  // _controller = VideoPlayerController.network(
                                  //     videoC
                                  //         .allVideoList[
                                  //             videoC.selectedIndex.value]
                                  //         .videoUrl)
                                  //   ..initialize().then((_) {
                                  //     setState(() {});
                                  //   });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xffa5a5a5),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      height: 120,
                                      width: 120,
                                    ),
                                    const Positioned(
                                      left: 35,
                                      top: 32,
                                      child: Icon(
                                        Icons.play_circle_outline_outlined,
                                        size: 50,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SpaceHorizontal(horizontal: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SpaceVertical(vertical: 15),
                                      Ktext(
                                        text: item.caption,
                                        fontSize: 18,
                                        fontColor: Colors.white54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SpaceVertical(vertical: 04),
                                      Ktext(
                                        text: DateFormat('dd - MM - yyyy')
                                            .format(item.createdAt),
                                        fontSize: 12,
                                      ),
                                      SpaceVertical(vertical: 52),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        StatefulBuilder(builder:
                                                            (context,
                                                                setState) {
                                                          return Obx(
                                                              () => AlertDialog(
                                                                    title: Text(
                                                                        '${videoC.downloadProgress.value.toStringAsFixed(2)}%'),
                                                                    content: LinearProgressIndicator(
                                                                        value: (videoC.downloadProgress.value /
                                                                            100)),
                                                                  ));
                                                        }));
                                                videoC.selectedIndex.value =
                                                    index;
                                                // await videoC
                                                //     .downloadFile(
                                                //   url:
                                                //       item.videoUrl,
                                                // );

                                                await videoC.downloadFile(
                                                    item.videoUrl);
                                                if (videoC.downloadProgress
                                                        .value >=
                                                    100) {
                                                  Get.back();
                                                }
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffa5a5a5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            04)),
                                                child: const Icon(
                                                  Icons.download,
                                                  size: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              Share.share(
                                                  item.videoUrl.toString());
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffa5a5a5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          04)),
                                              child: const Icon(
                                                Icons.share,
                                                size: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Ktext(
                                      text: item.id.toString(),
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                      // if (index != 0) {
                      //   videoC.initializePlayerC(item.videoUrl);
                      // }
                      //   return Obx(() => videoC.isInitialize.value
                      // SizedBox(
                      //       child: GestureDetector(
                      //           onTap: () async {},
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Container(
                      //                 decoration:
                      //                     const BoxDecoration(
                      //                         boxShadow: [
                      //                       BoxShadow(
                      //                           offset: Offset(1, 1),
                      //                           color: Colors.white)
                      //                     ]),
                      //                 height: videoC
                      //                     .videoPlayerController
                      //                     .value
                      //                     .size
                      //                     .height,
                      //                 width: videoC
                      //                     .videoPlayerController
                      //                     .value
                      //                     .size
                      //                     .width,
                      //                 child: videoC.chewieController !=
                      //                             null &&
                      //                         videoC
                      //                             .videoPlayerController
                      //                             .value
                      //                             .isInitialized
                      //                     ? AspectRatio(
                      //                         aspectRatio: videoC
                      //                             .videoPlayerController
                      //                             .value
                      //                             .aspectRatio,
                      //                         child: Chewie(
                      //                             controller: videoC
                      //                                 .chewieController!),
                      //                       )
                      //                     : const SizedBox(
                      //                         height: 20,
                      //                         width: 20,
                      //                         child:
                      //                             CircularProgressIndicator())),
                      //           )))
                      //   : const Center(
                      //       child: Text(
                      //         'Initializing....',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ));
                    },
                  )))
        ],
      )),
    );
  }
}
