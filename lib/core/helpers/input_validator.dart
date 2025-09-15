class InputValidator {
  //
  static String noEmptyFiled = 'لا يمكن ترك الحقل فارغ';
  static String invalidUrl = "ادخل رابط صالح";

  //
  static String? notEmptyValidator(String? text) {
    //
    if (text == null) return noEmptyFiled;
    if (text.isEmpty) return noEmptyFiled;
    text.trim();
    //
    return null;
  }

  //
  static String? urlValidator(String? text) {
    //
    if (text == null || text.trim().isEmpty) return noEmptyFiled;
    //
    try {
      final uri = Uri.parse(text.trim());
      if (!(uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https') && uri.hasAuthority)) {
        return invalidUrl;
      }
    } catch (e) {
      return invalidUrl;
    }
    return null;
  }

  static String? nameValidator(String? text) {
    //
    if (text == null) return noEmptyFiled;
    if (text.isEmpty) return noEmptyFiled;
    text.trim();
    //
    return null;
  }

  static String? numberValidator(String? text) {
    //
    if (text == null) return noEmptyFiled;
    if (text.isEmpty) return noEmptyFiled;
    text.trim();
    //
    if (int.tryParse(text) == null) {
      return "ادخل رقم صحيح";
    }
    //
    return null;
  }

  static String? emailValidator(String? text) {
    //
    if (text == null) return noEmptyFiled;
    if (text.isEmpty) return noEmptyFiled;
    text.trim();
    //
    final validCharacters = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!validCharacters.hasMatch(text)) {
      return 'ادخل بريد إلكتروني صالح';
    }
    return null;
  }

  static String? passwordValidator(String? text) {
    //
    if (text == null) return noEmptyFiled;
    if (text.isEmpty) return noEmptyFiled;
    text.trim();
    //
    if (text.length < 8) {
      return "الرمز السري يجب أن يتالف من 8 أحرف او أكثر";
    }

    return null;
  }

  static String? phoneValidator(String? text) {
    //
    if (text == null) return noEmptyFiled;
    if (text.isEmpty) return noEmptyFiled;
    text.trim();
    //
    final validCharacters = RegExp(r'^[0-9]+$');

    if (text.length != 10 || !validCharacters.hasMatch(text)) {
      return 'ادخل رقم هاتف صالح';
    }
    return null;
  }
}
