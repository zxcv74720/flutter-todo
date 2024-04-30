import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'modules/login/controller/kakao_login_controller.dart';
import 'modules/login/views/login_screen.dart';

void main() {
  // 환경 변수에서 암호화된 Kakao 네이티브 앱 키를 가져옴
  String nativeAppKey = Platform.environment['KAKAO_NATIVE_APP_KEY'] ?? '';

  KakaoSdk.init(nativeAppKey: nativeAppKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(KakaoLoginController());
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TokenCheck(),
    );
  }
}