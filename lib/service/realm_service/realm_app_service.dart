import 'dart:io';

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_app/core.dart';

class RealmAppService {
  static const String BASE_URL = "https://realm.mongodb.com";
  static const String DATA_SOURCE_NAME = "mongodb-atlas";
  static late App app;
  static late AppConfiguration appConfiguration;
  static init() {
    Map realmConfig = {
      "appId": APP_ID,
      "appUrl": APP_URL,
      "baseUrl": BASE_URL,
      "dataSourceName": DATA_SOURCE_NAME,
    };

    String appId = realmConfig["appId"];
    appConfiguration = AppConfiguration(
      appId,
      baseUrl: Uri.parse(BASE_URL),
      httpClient: HttpClient(),
    );
    app = App(appConfiguration);
  }

  static bool syncronized = false;
  static Future syncronizeAll() async {
    print("${AuthService.currentUser?.id}");
    print("${AuthService.currentUser?.profile.email}");
    print("${AuthService.currentUser?.profile.name}");
    if (AuthService.currentUser == null) {
      print("Login is required for Sync");
      return;
    }
    syncronized = false;
    await RealmSyncronizer.syncronize();

    syncronized = true;
    return true;
  }
}

extension RealmSyncronizerWidget on Widget {
  syncronizeRealm({
    required List<SchemaObject> schemaList,
  }) {
    if (RealmAppService.syncronized) return this;
    return FutureBuilder(
      future: RealmAppService.syncronizeAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return this;
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}
