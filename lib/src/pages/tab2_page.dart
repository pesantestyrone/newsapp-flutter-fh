import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/my_theme.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:newsapp/src/extensions/string_extension.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsServices>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategorias(),
            Expanded(
              child: ListaNoticias(newsService.getArticlesByCategorySelected),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsServices>(context).categories;

    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                SizedBox(height: 5.0),
                Text(categories[index].name.inCaps)
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;
  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsServices>(context);
    return GestureDetector(
      onTap: () {
        //listen=false solo se usa cuando se instancia dentro de ontap o similar
        final newsService = Provider.of<NewsServices>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: (newsService.selectedCategory == category.name)
            ? Icon(category.icon, color: myTheme.accentColor)
            : Icon(category.icon, color: Colors.black54),
      ),
    );
  }
}
