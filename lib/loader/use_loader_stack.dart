import 'package:flutter/cupertino.dart';
import 'package:interface_example/loader/use_loader_page.dart';

/// A classe UseLoaderStack é responsável pelo gerenciamento das páginas criadas durante a interação do usuário
/// São registradas as páginas que o usuário já acessou para aumentar o tempo de resposta quando ele tentar acessar a mesma página novamente
class UseLoaderStack {
  static UseLoaderStack _instance;
  static Map<String, UseLoaderPage> listPage = {};

  /// Construtor da classe
  factory UseLoaderStack() {
    _instance ??= UseLoaderStack._internalConstructor();
    return _instance;
  }

  UseLoaderStack._internalConstructor();

  static Widget page(String id) {
    return UseLoaderStack.listPage[id].widget;
  }

  static registrer(String id, Widget widget) {
    UseLoaderStack.listPage[id] = UseLoaderPage(widget: widget);
  }

  static dispose(String id) {
    if (exist(id)) {
      //UseLoaderStack.listPage[id].dispose();
      UseLoaderStack.listPage[id] = null;
      UseLoaderStack.listPage.remove(id);
    }
  }

  static bool exist(String id) {
    return UseLoaderStack.listPage[id] != null;
  }

  static destroy() {
    UseLoaderStack.listPage.forEach((String id, UseLoaderPage useLoaderPage) {
      print(id + ' -- ' + useLoaderPage.createdAt.toString());
    });
  }
}
