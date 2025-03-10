class VTextFormatter {

  static String formatFirebaseErrorText(String errTxt) {
      String formattedText = errTxt.split("/").last;
      return "[$formattedText";
  }
}