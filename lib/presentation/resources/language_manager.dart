
enum LanguagesType { english, arabic }

const String arabic = "ar";
const String english = "en";

extension LanguagesTypeExtension on LanguagesType {
  String getValue() {
    switch (this) {
      case LanguagesType.english:
        return english;
      case LanguagesType.arabic:
        return arabic;
    }
  }
}
