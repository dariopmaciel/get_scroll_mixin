import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_scroll_mixin/pages/user_list_controller.dart';

class UserListPage extends StatelessWidget {
  final controller = Get.find<UserListController>();
  UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      // floatingActionButton:
      //     FloatingActionButton(onPressed: () => controller.atualizar()),
      body: controller.obx((state) {
        //
        final totalItens = state?.length ?? 0;

        //!link do 'onEndScroll do mixinScroll' ao listview.builder
        return ListView.builder(
          //*link
          controller: controller.scroll,
          //! afim de se obser uma pagina de folga (respiro para internet ruim)
          //! itemCount: state?.length ?? 0,
          //* da erro
          //* itemCount: (state?.length ?? 0) + 1,
          itemCount: totalItens + 1,
          itemBuilder: (context, index) {
            //necessario fazer verificação do estado
            if (index == totalItens) {
              return Obx(
                () {
                  return Visibility(
                    visible: controller.isLoading,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Carregando novos usuários...',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            final user = state?[index];
            return ListTile(
              title: Text(user?.name ?? 'Sem nome'),
              subtitle: Text(user?.email ?? 'Sem email'),
            );
          },
        );
      }),
    );
  }
}
