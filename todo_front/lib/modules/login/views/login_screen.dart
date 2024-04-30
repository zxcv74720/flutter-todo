import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:todo_front/modules/task/views/home_screen.dart';
import '../controller/kakao_login_controller.dart';

class TokenCheck extends StatefulWidget {
  const TokenCheck({Key? key}) : super(key: key);

  @override
  State<TokenCheck> createState() => _TokenCheckState();
}

class _TokenCheckState extends State<TokenCheck> {
  bool _isToken = false;

  @override
  void initState() {
    _checkKakaoLogin();
    super.initState();
  }

  void _checkKakaoLogin() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        Get.find<KakaoLoginController>().addUserInfo();
        setState(() {
          _isToken = true;
        });

      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }
      }
    } else {
      print('발급된 토큰 없음');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isToken ? const HomeScreen() : const LoginScreen();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.find<KakaoLoginController>().login();
                    },
                    child: Text('로그인'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
