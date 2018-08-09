import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/page/login_page.dart';

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
