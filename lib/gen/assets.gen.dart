/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/hippo_logo.png
  AssetGenImage get hippoLogo =>
      const AssetGenImage('assets/images/hippo_logo.png');

  /// File path: assets/images/hippo_logo_text.png
  AssetGenImage get hippoLogoText =>
      const AssetGenImage('assets/images/hippo_logo_text.png');

  /// List of all assets
  List<AssetGenImage> get values => [hippoLogo, hippoLogoText];
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// File path: assets/vectors/hippo_logo.svg
  SvgGenImage get hippoLogo =>
      const SvgGenImage('assets/vectors/hippo_logo.svg');

  /// File path: assets/vectors/hippo_logo_text.svg
  SvgGenImage get hippoLogoText =>
      const SvgGenImage('assets/vectors/hippo_logo_text.svg');

  /// File path: assets/vectors/ic_calendar.svg
  SvgGenImage get icCalendar =>
      const SvgGenImage('assets/vectors/ic_calendar.svg');

  /// File path: assets/vectors/ic_email.svg
  SvgGenImage get icEmail => const SvgGenImage('assets/vectors/ic_email.svg');

  /// File path: assets/vectors/ic_fingerprint.svg
  SvgGenImage get icFingerprint =>
      const SvgGenImage('assets/vectors/ic_fingerprint.svg');

  /// File path: assets/vectors/ic_language.svg
  SvgGenImage get icLanguage =>
      const SvgGenImage('assets/vectors/ic_language.svg');

  /// File path: assets/vectors/ic_phone.svg
  SvgGenImage get icPhone => const SvgGenImage('assets/vectors/ic_phone.svg');

  /// File path: assets/vectors/ic_referal.svg
  SvgGenImage get icReferal =>
      const SvgGenImage('assets/vectors/ic_referal.svg');

  /// File path: assets/vectors/ic_user.svg
  SvgGenImage get icUser => const SvgGenImage('assets/vectors/ic_user.svg');

  /// File path: assets/vectors/ic_web.svg
  SvgGenImage get icWeb => const SvgGenImage('assets/vectors/ic_web.svg');

  /// File path: assets/vectors/instant_load.svg
  SvgGenImage get instantLoad =>
      const SvgGenImage('assets/vectors/instant_load.svg');

  /// File path: assets/vectors/no_collateral.svg
  SvgGenImage get noCollateral =>
      const SvgGenImage('assets/vectors/no_collateral.svg');

  /// File path: assets/vectors/seamless_process.svg
  SvgGenImage get seamlessProcess =>
      const SvgGenImage('assets/vectors/seamless_process.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        hippoLogo,
        hippoLogoText,
        icCalendar,
        icEmail,
        icFingerprint,
        icLanguage,
        icPhone,
        icReferal,
        icUser,
        icWeb,
        instantLoad,
        noCollateral,
        seamlessProcess
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVectorsGen vectors = $AssetsVectorsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
