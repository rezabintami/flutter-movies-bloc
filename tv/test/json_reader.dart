import 'dart:io';

String readJson(String name, String module) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/$module/test/$name').readAsStringSync();
}
