import 'package:get/get.dart';
import 'package:get_scroll_mixin/models/user_model.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

class UserListController extends GetxController
    with StateMixin<List<UserModel>> {
      
  final UserRepository _userRepository;

  UserListController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  void onReady() {
    print('onReady');
    //*Para quando a tela estiver montada
    _findUser();
    super.onReady();
  }

  Future<void> _findUser() async {
    //buscar dados e alterar status
    final result = await _userRepository.getUsers();
    //alterar estado
    change(result, status: RxStatus.success());
  }
}
