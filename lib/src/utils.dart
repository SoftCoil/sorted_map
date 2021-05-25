import 'package:logging/logging.dart';

void initLogger() {
  Logger.root.level = Level.INFO; //INFO is the default if not set.
  Logger.root.onRecord.listen((LogRecord rec) {
    if (rec.error == null) {
      print(
          '${rec.time} - ${rec.level.name} - ${rec.loggerName}: ${rec.message}');
    } else {
      print(
          '${rec.time} - ${rec.level.name} - ${rec.loggerName}: ${rec.message}: ${rec.error}');
      if (rec.stackTrace != null) {
        print('${rec.stackTrace}');
      }
    }
  });
}
