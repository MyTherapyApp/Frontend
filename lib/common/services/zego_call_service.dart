import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../main.dart'; // تأكدي من مسار ملف الـ main عندك لربط الـ navigatorKey
import '../constants/app_constants.dart'; // تأكدي من مسار الـ AppConstants

class ZegoCallService {
  // دالة تهيئة الرنة والاتصال
  static Future<void> initZegoService({
    required String userID,
    required String userName,
  }) async {
    try {
      // 1. ربط الـ navigatorKey عشان شاشة الرنة تفتح فوق أي شاشة تانية
      ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

      // 2. عمل الـ Init للخدمة
      await ZegoUIKitPrebuiltCallInvitationService().init(
        appID: AppConstants.appID,
        appSign: AppConstants.appSign,
        userID: userID,
        userName: userName,
        plugins: [ZegoUIKitSignalingPlugin()],
      );

      debugPrint("✅ Zego Call Service Initialized Successfully for: $userID");
    } catch (e) {
      debugPrint("❌ Zego Call Service Init Error: $e");
    }
  }

  // دالة لإغلاق الخدمة عند تسجيل الخروج (مهمة جداً)
  static void uninitZegoService() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    debugPrint("🚪 Zego Call Service Uninitialized (Logged out).");
  }
}