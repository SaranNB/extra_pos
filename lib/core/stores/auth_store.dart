import 'package:extra_pos/core/routing/app_route.dart';
import 'package:extra_pos/core/services/local_storage_get.dart';
import 'package:extra_pos/core/utils/jwt_decoder.dart';
import 'package:get/get.dart';

class AuthStore extends GetxController {
  AuthStore(this._storage);

  static AuthStore get to => Get.find();

  static const ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const REFRESH_TOKEN = 'REFRESH_TOKEN';

  String? accessToken;
  String? refreshToken;

  final LocalStorage _storage;
  final isLogged = true.obs;

  @override
  void onInit() {
    super.onInit();
    accessToken = _storage.read(ACCESS_TOKEN);
    refreshToken = _storage.read(REFRESH_TOKEN);
    if (accessToken == null || refreshToken == null) {
      isLogged.value = false;
    }
  }

  bool isLoggedIn() {
    return isLogged.value;
  }

  void login() {
    if (isLoggedIn())
      Get.offAllNamed(Routes.home);
    else
      Get.offAllNamed(Routes.login);
  }

  void saveTokens(String? accessToken, String? refreshToken) {
    saveTokensAsync(accessToken, refreshToken);
    update();
  }

  void saveTokensAsync(String? accessToken, String? refreshToken) async {
    await _storage.write(ACCESS_TOKEN, accessToken);
    await _storage.write(REFRESH_TOKEN, refreshToken);
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    update();
  }

  void saveAccessToken(String accessToken) {
    saveAccessTokenAsync(accessToken);
    update();
  }

  Future saveAccessTokenAsync(String accessToken) async {
    await _storage.write(ACCESS_TOKEN, accessToken);
    this.accessToken = accessToken;
    update();
  }

  void saveRefreshToken(String refreshToken) {
    saveRefreshTokenAsync(refreshToken);
    update();
  }

  void saveRefreshTokenAsync(String accessToken) async {
    await _storage.write(REFRESH_TOKEN, refreshToken);
    this.refreshToken = refreshToken;
    update();
  }

  bool isAccessTokenExpired() {
    return JwtDecoder.isExpired(accessToken!);
  }

  bool isRefreshTokenExpired() {
    return JwtDecoder.isExpired(refreshToken!);
  }

  Future<void> logout() async {
    await _storage.remove(ACCESS_TOKEN);
    await _storage.remove(REFRESH_TOKEN);
    accessToken = null;
    refreshToken = null;
    isLogged.value = false;
    update();

    Get.offAllNamed(Routes.login);
  }

  Future<void> logoutAndGotoConfig() async {
    await _storage.remove(ACCESS_TOKEN);
    await _storage.remove(REFRESH_TOKEN);
    accessToken = null;
    refreshToken = null;
    isLogged.value = false;
    update();

    Get.offAllNamed(Routes.appUrlConfig);
  }
}
