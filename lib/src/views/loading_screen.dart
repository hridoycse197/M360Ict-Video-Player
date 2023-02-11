import 'dart:developer';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:native_video_view/native_video_view.dart';

import '../config/base.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/vertical_space_widget.dart';

class LoadingScreen extends StatelessWidget with Base {
  LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor:  Color(0xff242730),
        body:  SafeArea(
            child:
                  
                Center(
                    child: Text(
                      'Loading.....',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          
        ));
  }
}
