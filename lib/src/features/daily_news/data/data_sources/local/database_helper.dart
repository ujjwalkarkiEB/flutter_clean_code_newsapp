import 'package:flutter_clean_code_news_app/src/core/utils/constants/string_constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  Future<void> initializeLocalDatabase() async {
    final databaseDir = await getApplicationDocumentsDirectory();
    Hive.init(databaseDir.path);
    await Hive.openBox<String>(boxName);
  }

  Box<String> get articleBox => Hive.box(boxName);
}
