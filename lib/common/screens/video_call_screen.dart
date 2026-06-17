import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../constants/app_constants.dart';

class CallPage extends StatelessWidget {
  final String callID;
  final String userID;
  final String userName;
  final bool isTherapist;

  const CallPage({
    super.key,
    required this.callID,
    required this.userID,
    required this.userName,
    this.isTherapist = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: AppConstants.appID,
        appSign: AppConstants.appSign,
        userID: userID,
        userName: userName,
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..bottomMenuBar.buttons = isTherapist
              // أزرار الدكتور (ممكن تضيفي أو تقللي براحتك هنا)
              ? [
                  ZegoCallMenuBarButtonName.toggleCameraButton,
                  ZegoCallMenuBarButtonName.toggleMicrophoneButton,
                  ZegoCallMenuBarButtonName.hangUpButton,
                  ZegoCallMenuBarButtonName.switchCameraButton,
                ]
              // أزرار المريض
              : [
                  ZegoCallMenuBarButtonName.toggleCameraButton,
                  ZegoCallMenuBarButtonName.toggleMicrophoneButton,
                  ZegoCallMenuBarButtonName.hangUpButton,
                  ZegoCallMenuBarButtonName.switchCameraButton,
                ],
      ),
    );
  }
}