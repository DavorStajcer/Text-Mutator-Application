import 'dart:io';

String readFileFail(String filename) {
  return File('fixtures/testing_texts_fail/$filename.txt').readAsStringSync();
}

String readFileSuccess(String filename) {
  return File('fixtures/testing_texts_pass/$filename.txt').readAsStringSync();
}
