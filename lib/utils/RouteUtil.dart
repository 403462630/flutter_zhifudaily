import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/page/login_page.dart';
import 'package:flutter_zhifudaily/page/news_detail_page.dart';
import 'package:flutter_zhifudaily/page/web_view_page.dart';

void gotoLogin(BuildContext context) {
  Navigator.of(context).push(new PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return new LoginPage();
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//        print("animation ${animation.value}, secondaryAnimation ${secondaryAnimation.value}");
//        Tween tween = new Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero);
//        tween.evaluate(animation);
//        print("tween ${tween.evaluate(animation)}");
        return new SlideTransition(
          child: child,
          position: new Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(animation),
        );
      }
  ));
}

void gotoNewsDetailPage(BuildContext context, int id) {
  Navigator.of(context).push(new PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return new NewsDetailPage(id: id);
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//        return new FadeTransition(
//          child: new ScaleTransition(
//            child: child,
//            scale: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//          ),
//          opacity: animation,
//        );
        return new SlideTransition(
          child: child,
          position: new Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(animation),
        );
      }
  ));
}

void gotoWebViewPage(BuildContext context, String url, String title) {
  Navigator.of(context).push(new PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return new WebViewPage(url: url, title: title);
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          child: child,
          position: new Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(animation),
        );
      }
  ));
}

