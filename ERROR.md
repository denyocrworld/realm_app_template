# Kamu wajib menginstall freezed untuk project ini
# Jalankan perintah ini di terminal:

dart pub add freezed_annotation json_annotation mobx flutter_mobx mobx_codegen
dart pub add --dev build_runner freezed json_serializable injectable_generator

# Jangan lupa jalankan build_runner kalau tidak project ini tidak bekerja!
dart pub run build_runner watch --delete-conflicting-outputs

# Kadang2 build_runner bisa saja error, jangan panik
# Tutup vscode, lalu jalankan ulang build_runner

dart pub run build_runner watch --delete-conflicting-outputs

# Jika masih belum bekerja, jalankan build_runner tanpa argument
dart pub run build_runner watch