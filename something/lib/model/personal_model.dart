import 'package:flutter/widgets.dart';
import 'package:something/api/personal_api.dart';
import 'package:something/service_locator.dart';
import 'package:something/utils/local_storage_service.dart';

class PersonalModel extends ChangeNotifier {
  String? username;
  bool? needLogin;
  final LocalStorageService storageService = locator<LocalStorageService>();

  Future<void> initData() async {
    username = storageService.userName ?? '';

    if (username != null && username != '') {
      needLogin = false;
    } else {
      needLogin = true;
    }
  }

  Future logout() async {
    bool successful = await PersonalApi.logout();
    if (successful) {
      storageService.clear();
      // Navigator
    } else {}
  }
}
