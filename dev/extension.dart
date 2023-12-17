extension StringExtensions on String {
  // Method untuk mengubah string ke dalam format ClassName (tanpa spasi dan underscore)
  String get className {
    return this.splitMapJoin(
      RegExp(r'[A-Za-z0-9]+'),
      onMatch: (match) => match.group(0)!.capitalize(),
      onNonMatch: (nonMatch) => '',
    );
  }

  // Method untuk mengubah string ke dalam format camelCase (tanpa spasi dan underscore)
  String get variableName {
    final words = this.keyName.split(RegExp(r'[ _]'));
    String result = words.first.toLowerCase();
    for (var i = 1; i < words.length; i++) {
      result += words[i].capitalize();
    }
    return result;
  }

  // Method untuk mengubah string ke dalam format key_name (lowercase, kata dipisah dengan _)
  String get keyName {
    String cleanedString = this.replaceAllMapped(
        RegExp(r'([A-Z])'), (match) => '_${match.group(1)!.toLowerCase()}');
    // Menghilangkan underscore di awal jika ada
    if (cleanedString.startsWith('_')) {
      cleanedString = cleanedString.substring(1);
    }
    return cleanedString.toLowerCase();
  }

  // Method untuk mengubah string ke dalam format title_case (setiap kata dengan huruf kapital)
  String get titleCase {
    final words = this.keyName.split(RegExp(r'[ _]'));
    String result = '';
    for (var word in words) {
      if (result.isNotEmpty) {
        result += ' ';
      }
      result += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
    return result;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
