import 'package:demo_app/const/assets.dart';

class HelperClass{
  static String fetchAssetsFromSubCategoryName(String name) {
    switch (name) {
      case "Lyrics":
        return AssetsManager.icMusic;
      case "Poem":
        return AssetsManager.icPage;
      case "Write a paragraph":
        return AssetsManager.icWriting;
      case "Summarize (TL;DR)":
        return AssetsManager.icChat;
      case "Company Bio":
        return AssetsManager.icBriefacse;
      default:
        return AssetsManager.icOthers;
    }
  }
}