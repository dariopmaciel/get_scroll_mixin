import 'package:get/get.dart';
import 'package:get_scroll_mixin/models/user_model.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

class UserListController extends GetxController
    with StateMixin<List<UserModel>>, ScrollMixin {
  final UserRepository _userRepository;
  late final Worker workerPage;
  //!Ao criar limitador 'inicio' e limitador de 'página' é necessario enviar e receber estes limites
  //! Enviar para o backend para o getUser
  final _page = 1.obs;
  final _limit = 12;
  final _loading = false.obs;

  UserListController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  bool get isLoading => _loading.value;

//!para ficar escutando as ações do usuario énecessario um worker => onInit
  @override
  void onInit() {
    //!quando acontecer qlqr alteração na minha página, QUALQUER UMA, será chamado o '_findUser'
    workerPage = ever<int>(_page, (_) {
      _findUser();
    });
    super.onInit();
  }

//*apenas para incrementar +1 pagina.
//todo - mas esta atualizando a pagina toda, e oque eu quero é addicionar a pag inicial mais inf, deixando ela com 20 nomes
  void atualizar() => _page.value++;

  @override
  void onReady() {
    // ignore: avoid_print
    print('onReady');
    //*Para quando a tela estiver montada
    _findUser();
    super.onReady();
  }

  @override
  void onClose() {
    workerPage();
  }

  Future<void> _findUser() async {
    //estou buscando dados
    _loading(true);
    //!passando por aqui
    final result = await _userRepository.getUsers(_page.value, _limit);
    //! para add a pag inicial nova pagina, foi criado o 'stateResult' e add a ele o state result
    //(mais ou menos 'concatenando inf')
    final stateResult = state ?? [];
    stateResult.addAll(result);

    //alterar estado
    // change(result, status: RxStatus.success());
    change(stateResult, status: RxStatus.success());
    //terminei de buscar dados e conclui;
    _loading(false);
  }

  @override
  Future<void> onTopScroll() async {
    //!!NÃO é necessárioser USADO!!
    //*mas com ele, as paginas não usadas serão descarregadas
    _page.value--;
  }

  @override
  Future<void> onEndScroll() async {
    //se o carregamento for falso DAI carrega e conta pagina
    if (!isLoading) {
      _page.value++;
    }
  }
}
