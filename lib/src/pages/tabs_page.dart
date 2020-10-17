import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navModel.paginaActual,
      onTap: (i) => navModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text('Para ti'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          title: Text('Encabezados'),
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navModel._pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginalActual = 0;
  PageController _pageController = PageController();

  int get paginaActual => this._paginalActual;

  set paginaActual(int valor) {
    this._paginalActual = valor;

    _pageController.animateToPage(
      valor,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );

    notifyListeners();
  }

  PageController get pageController => _pageController;
}
