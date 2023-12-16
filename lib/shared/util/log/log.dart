import 'package:realm_app/core.dart';

p(String message) {
  print(message);
}

py(String message) {
  printy(message);
}

pr(String message) {
  printr(message);
}

pg(String message) {
  printg(message);
}

po(String message) {
  printo(message);
}

pb(String message) {
  printb(message);
}

//--------------

get pl => p("----------------------");
get pyl => py("----------------------");
get prl => pr("----------------------");
get pgl => pg("----------------------");
get pol => po("----------------------");
get pbl => pb("----------------------");

// ~~ PRINT ~~

void printr(String text) {
  print('\x1B[31m$text\x1B[0m'); // Merah
}

void printg(String text) {
  print('\x1B[32m$text\x1B[0m'); // Hijau
}

void printo(String text) {
  print('\x1B[38;5;208m$text\x1B[0m'); // Oranye
}

void printy(String text) {
  print('\x1B[33m$text\x1B[0m'); // Kuning
}

void printb(String text) {
  print('\x1B[34m$text\x1B[0m'); // Biru
}

// ~ SNACKBAR ~ //

ss(String message) {
  snackbarSuccess(message: message);
}

se(String message) {
  snackbarDanger(message: message);
}
