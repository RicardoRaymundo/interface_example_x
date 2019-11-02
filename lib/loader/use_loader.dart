import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:interface_example/loader/use_loader_stack.dart';

/// A classe UseLoader é responsável pelo carregamento de páginas já registradas em memória
class UseLoader extends StatelessWidget {
  final String id;
  final Widget page;

  UseLoader({@required this.id, @required this.page});

  @override
  Widget build(BuildContext context) {
    const TIMEOUT = const Duration(seconds: 1);
    findPage() async {
      /// Verifica se a página já está registrada em memória
      if (UseLoaderStack.exist(this.id)) {
        return await UseLoaderStack.page(this.id);
      }
      /// Caso contrário registra na memória e retorna
      else {
        UseLoaderStack.destroy();
        return Future.delayed(TIMEOUT, () {
          UseLoaderStack.registrer(this.id, this.page);
          return this.page;
        });
      }
    }

    /// Asynchronous
    Future<Widget> loader() async {
      return await findPage();
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: AsyncLoader(
          initState: () async => await loader(),
          renderLoad: () => CircularProgressIndicator(),
          renderError: ([error]) => Text('Error: UseLoader'),
          renderSuccess: ({data}) {
            return data;
          },
        ),
      ),
    );
  }
}
