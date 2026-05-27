import 'dart:convert';
import 'dart:io';

import 'package:fitai/models/anamnesis_data.dart';

abstract final class AnamnesisStore {
  static const _directoryName = 'fitai';
  static const _fileName = 'anamnesis.json';

  static Future<void> save(AnamnesisData data) async {
    final file = await _localFile;
    await file.writeAsString(jsonEncode(data.toJson()), flush: true);
  }

  static Future<AnamnesisData?> load() async {
    final file = await _localFile;

    if (!await file.exists()) {
      return null;
    }

    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return AnamnesisData.fromJson(json);
  }

  static Future<File> get _localFile async {
    final basePath =
        Platform.environment['LOCALAPPDATA'] ??
        Platform.environment['APPDATA'] ??
        Directory.systemTemp.path;
    final directory = Directory(
      '$basePath${Platform.pathSeparator}$_directoryName',
    );

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return File('${directory.path}${Platform.pathSeparator}$_fileName');
  }
}
