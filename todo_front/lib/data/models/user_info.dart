class UserInfo {
  final int id;
  final String profileNickname;
  final String profileImage;
  final String accountEmail;

  UserInfo({
    required this.id,
    required this.profileNickname,
    required this.profileImage,
    required this.accountEmail,
  });

  factory UserInfo.fromMap(Map userInfoMap) {
    return UserInfo(
      id: userInfoMap['id'],
      profileNickname: userInfoMap['profileNickname'],
      profileImage: userInfoMap['profileImage'],
      accountEmail: userInfoMap['accountEmail'],
    );
  }
}
