import 'package:get/get.dart';

import '../response_models/otp_response_model.dart';

class GetLoginModalService extends GetxService {
  UserDetails? _userDataModal;



  @override
  void onInit() {
    super.onInit();
  }
  UserDetails? getUserDataModal({required UserDataModel}) {
    return _userDataModal;
  }

  void setUserDataModal({required UserDetails? userDataModal}) {
    _userDataModal = userDataModal;
  }


}