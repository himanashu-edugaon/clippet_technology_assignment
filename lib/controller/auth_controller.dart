
import 'package:get/get.dart';
import '../model/user_model.dart';
import '../view/home_screen.dart';
import '../view/screens/auth_screen/login_screen.dart';
import 'db_helper.dart';
import 'localstorage_services.dart';

class AuthController extends GetxController {
  var authService = DbHelper();
  var isLoggedIn = false.obs;
  var user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    authService.initDb();

  }

  Future<void> checkLoginStatus() async {
    String? userEmail = await LocalStorageService.getUserSession();
    print(userEmail);
    if (userEmail != null) {
      getUserData();
      isLoggedIn.value = true;
      Get.offAll(() => HomeScreen());
    } else {
      isLoggedIn.value = false;
      Get.offAll(() => LoginScreen());
    }
  }

  Future<bool> login(String name, String password) async {
    var data = await authService.loginUser(name, password);
    if (data != null) {
      await LocalStorageService.saveUserSession(name);
      user.value = data;
      return true;
    } else {
      return false;
    }
  }

  Future<void> signup(String name, String email, String password,String phone,String profession) async {
    var newUser = UserModel(name: name, email: email, password: password,phone: phone,profession: profession);
    await authService.registerUser(newUser);
    await LocalStorageService.saveUserSession(name);
    user.value = newUser;
    Get.offAll(() => HomeScreen());
  }

  Future<void> logout() async {
    await LocalStorageService.clearUserSession();
    user.value = null;
    Get.offAll(() => const LoginScreen());
  }

  void getUserData() async {
    var currentUserName = await LocalStorageService.getUserSession();
    await initializeUserData(name: currentUserName);
  }

  Future<void> initializeUserData({required String? name}) async {
    try {
      if (name != null) {
        user.value = await DbHelper().getUserByName(name);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

}
