import 'dart:async';
import 'dart:io';

import 'package:flutter_zhifudaily/api/domain_config.dart';
import 'package:flutter_zhifudaily/api/log_interceptor.dart';
import 'package:flutter_zhifudaily/data/editor.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/data/stories.dart';
import 'package:flutter_zhifudaily/data/theme.dart';
import 'package:dio/dio.dart';


abstract class ZhiFuNewsApi {
  static _ZhiFuNewsApiImpl _apiImpl;
  ZhiFuNewsApi.protected();

  factory ZhiFuNewsApi() {
    if (_apiImpl == null) {
      _apiImpl = new _ZhiFuNewsApiImpl();
    }
    return _apiImpl;
  }

  /// 主题列表
  Future<Result<ThemeResult>> getThemeList();

  /// 主题新闻列表
  Future<Result<ThemeNews>> getThemeNewsList(int themeId);

  /// 主题新闻列表--加载历史
  Future<Result<List<Stories>>> getThemeNewsListMore(int themeId, int lastStoriesId);

  /// 首页新闻列表
  Future<Result<HomeNews>> getHomeNewsList();

  /// 首页新闻列表--加载历史
  Future<Result<HomeNews>> getHomeNewsListMore(String date);
}

class _ZhiFuNewsApiImpl extends ZhiFuNewsApi {

  Dio _dio;
  _ZhiFuNewsApiImpl() : super.protected() {
    Options options = new Options(
      baseUrl: DomainConfig.getDomain(DomainType.ZHI_HU_DOMAIN),
      connectTimeout: 5000,
      receiveTimeout: 20000,
    );
    LogInterceptor logInterceptor = LogInterceptor();
    _dio = new Dio(options);
    _dio.interceptor.request.onSend = logInterceptor.onSend;
    _dio.interceptor.response.onError = logInterceptor.onError;
    _dio.interceptor.response.onSuccess = logInterceptor.onSuccess;
  }

  Result<T> _parseResponse<T>(Response response, T fn(dynamic data)) {
    Result<T> result = new Result();
    result.code = response.statusCode;
    if (response.statusCode == HttpStatus.OK) {
      try {
        result.data = fn(response.data);
      } catch (e) {
        print(e);
        result.code = 500;
        result.message = "数据解析失败";
      }
    } else {
      result.message = "服务器异常";
    }
    return result;
  }

  @override
  Future<Result<ThemeResult>> getThemeList() async {
    try {
      Response response = await _dio.get("api/4/themes");
      Result<ThemeResult> result = _parseResponse(response, (data) {
        ThemeResult themeResult = new ThemeResult(
          limit: data["limit"],
          subscribed: data["subscribed"],
          others: (data["others"] as List).map((t) => NewsTheme.fromJson(t)).toList(),
        );
        return themeResult;
      });
      return result;
    } catch (e) {
      print(e);
      return new Result(code: 500, message: "网络异常");
    }
  }

  @override
  Future<Result<ThemeNews>> getThemeNewsList(int themeId) async {
    try {
      Response response = await _dio.get("api/4/theme/" + themeId.toString());
      Result<ThemeNews> result = _parseResponse(response, (data) {
        ThemeNews themeNews = new ThemeNews(
          color: data["color"],
          background: data["background"],
          description: data["description"],
          image: data["image"],
          name: data["name"],
          editors: (data["editors"] as List).map((t) => Editor.fromJson(t)).toList(),
          stories: (data["stories"] as List).map((t) => Stories.fromJson(t)).toList(),
        );
        return themeNews;
      });
      return result;
    } catch (e) {
      print(e);
      return new Result(code: 500, message: "网络异常");
    }
  }

  @override
  Future<Result<List<Stories>>> getThemeNewsListMore(int themeId, int lastStoriesId) async {
    try {
      Response response = await _dio.get("api/4/theme/" + themeId.toString() + "/before/" + lastStoriesId.toString());
      Result<List<Stories>> result = _parseResponse(response, (data) {
        return (data["stories"] as List).map((t) => Stories.fromJson(t)).toList();
      });
      return result;
    } catch (e) {
      print(e);
      return new Result(code: 500, message: "网络异常");
    }
  }

  @override
  Future<Result<HomeNews>> getHomeNewsList() async {
    try {
      Response response = await _dio.get("api/4/news/latest");
      Result<HomeNews> result = _parseResponse(response, (data) {
        return new HomeNews(
          stories: data["stories"] != null ? (data["stories"] as List).map((t) => Stories.fromJson(t)).toList() : null,
          topStories: data["top_stories"] != null ? (data["top_stories"] as List).map((t) => TopStories.fromJson(t)).toList() : null,
          date: data["date"],
        );
      });
      return result;
    } catch (e) {
      print(e);
      return new Result(code: 500, message: "网络异常");
    }
  }

  @override
  Future<Result<HomeNews>> getHomeNewsListMore(String date) async {
    try {
      Response response = await _dio.get("api/4/news/before/" + date);
      Result<HomeNews> result = _parseResponse(response, (data) {
        return new HomeNews(
          stories: data["stories"] != null ? (data["stories"] as List).map((t) => Stories.fromJson(t)).toList() : null,
          date: data["date"],
        );
      });
      return result;
    } catch (e) {
      print(e);
      return new Result(code: 500, message: "网络异常");
    }
  }
}

