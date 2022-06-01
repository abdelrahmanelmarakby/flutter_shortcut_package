import 'package:ease/extensions/ease_utils.dart';

extension StringUtils on String {
  bool get isNum => EaseUtils.isNum(this);

  bool get isNumericOnly => EaseUtils.isNumericOnly(this);

  bool get isAlphabetOnly => EaseUtils.isAlphabetOnly(this);

  bool get isBool => EaseUtils.isBool(this);

  bool get isVectorFileName => EaseUtils.isVector(this);

  bool get isImageFileName => EaseUtils.isImage(this);

  bool get isAudioFileName => EaseUtils.isAudio(this);

  bool get isVideoFileName => EaseUtils.isVideo(this);

  bool get isTxtFileName => EaseUtils.isTxt(this);

  bool get isDocumentFileName => EaseUtils.isWord(this);

  bool get isExcelFileName => EaseUtils.isExcel(this);

  bool get isPPTFileName => EaseUtils.isPPT(this);

  bool get isAPKFileName => EaseUtils.isAPK(this);

  bool get isPDFFileName => EaseUtils.isPDF(this);

  bool get isHTMLFileName => EaseUtils.isHTML(this);

  bool get isURL => EaseUtils.isURL(this);

  bool get isEmail => EaseUtils.isEmail(this);

  bool get isPhoneNumber => EaseUtils.isPhoneNumber(this);

  bool get isDateTime => EaseUtils.isDateTime(this);

  bool get isMD5 => EaseUtils.isMD5(this);

  bool get isSHA1 => EaseUtils.isSHA1(this);

  bool get isSHA256 => EaseUtils.isSHA256(this);

  bool get isBinary => EaseUtils.isBinary(this);

  bool get isIPv4 => EaseUtils.isIPv4(this);

  bool get isIPv6 => EaseUtils.isIPv6(this);

  bool get isHexadecimal => EaseUtils.isHexadecimal(this);

  bool get isPalindrom => EaseUtils.isPalindrom(this);

  bool get isPassport => EaseUtils.isPassport(this);

  bool get isCurrency => EaseUtils.isCurrency(this);

  bool get isCpf => EaseUtils.isCpf(this);

  bool get isCnpj => EaseUtils.isCnpj(this);

  bool isCaseInsensitiveContains(String b) =>
      EaseUtils.isCaseInsensitiveContains(this, b);

  bool isCaseInsensitiveContainsAny(String b) =>
      EaseUtils.isCaseInsensitiveContainsAny(this, b);

  String? get capitalize => EaseUtils.capitalize(this);

  String? get capitalizeFirst => EaseUtils.capitalizeFirst(this);

  String get removeAllWhitespace => EaseUtils.removeAllWhitespace(this);

  String? get camelCase => EaseUtils.camelCase(this);

  String? get paramCase => EaseUtils.paramCase(this);

  String numericOnly({bool firstWordOnly = false}) =>
      EaseUtils.numericOnly(this, firstWordOnly: firstWordOnly);

  String createPath([Iterable? segments]) {
    final path = startsWith('/') ? this : '/$this';
    return EaseUtils.createPath(path, segments);
  }
}
