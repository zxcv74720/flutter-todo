import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:todo_front/data/models/user_info.dart';

import 'globals.dart';

class KakaoLoginProvider extends GetConnect implements GetxService {
  static const String loginURL = '$baseURL/login';

  static Future<UserInfo> addUserInfo(User user) async {
    Map<String, dynamic> data = {
      "id": user.id,
      "profileNickname": user.kakaoAccount?.profile?.nickname,
      "profileImage": user.kakaoAccount?.profile?.profileImageUrl,
      "accountEmail": user.kakaoAccount?.email,
    };

    var body = json.encode(data);
    print(body);
    var url = Uri.parse(loginURL + '/sign');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    UserInfo userInfo = UserInfo.fromMap(responseMap);

    return userInfo;
  }
}
