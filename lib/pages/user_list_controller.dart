import 'package:get/get.dart';
import 'package:get_scroll_mixin/models/user_model.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

class UserListController extends GetxController
    with StateMixin<List<UserModel>> {
  final UserRepository _userRepository;
  //!Ao criar limitador inicio e limitador de página é necessario enviar e receber estes limites
  final _page = 1.obs;
  final limit = 10;

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
//! seria trazer para ca????

  Future<void> _findUser() async {
    //buscar dados e alterar status
    final result = await _userRepository.getUsers();
    //alterar estado
    change(result, status: RxStatus.success());
  }
}
