import 'dart:io';

class FixtureReader {
  static String get(String path) => File('lib/fixtures/$path').readAsStringSync();
}
