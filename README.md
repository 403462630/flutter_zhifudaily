# flutter版 知乎日报 demo（仅供学习开发使用）

=====================
1. 用到的API是参考的[这里](https://github.com/izzyleung/ZhihuDailyPurify/wiki/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-API-%E5%88%86%E6%9E%90)
2. 登录功能没有实现，只是简单实现了登录页面的ui
3. Flutter原生不支持加载h5，所以使用了[flutter_webview_plugin](https://pub.dartlang.org/packages/flutter_webview_plugin)插件
4. Flutter原生不支持toast,所以使用了[fluttertoast](https://pub.dartlang.org/packages/fluttertoast)插件
5. Flutter禁止运行时反射，所以并没有类似 GSON / Jackson / Moshi 这些json序列化的库，但是有[json_serializable](https://pub.dartlang.org/packages/json_serializable)库自动帮你生成model代码（由于flutter beta版的bug，暂时用不了，只能手动解析了）
6. 源码里使用了一些android常用的代码结构，比如fragment、adapter等等


[APK下载地址](http://www.pgyer.com/vjc2)

