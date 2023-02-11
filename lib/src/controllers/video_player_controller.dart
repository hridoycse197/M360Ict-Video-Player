import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FeedVideoPlayerController extends GetxController {
  late VideoPlayerController? _controller;
  final isMusicOn = RxBool(false);
  final isPlayOn = RxBool(false);
  final controller = Rx<VideoPlayerController?>(null);
}