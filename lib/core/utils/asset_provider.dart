import 'package:gemchase_clean_arch/core/common/exports.dart';

import '../constants/constant_path.dart';

class _AssetsImagesGen {
  const _AssetsImagesGen();

  String get Logo => '$kImagesPath/Logo.png';
  String get Shoe => '$kImagesPath/shoe.png';
  String get Banner => '$kImagesPath/banner.png';
}

class _AssetsSvgImagesGen {
  const _AssetsSvgImagesGen();

  String get back => '$kSvgImagesPath/long_back.svg';
  String get menu => '$kSvgImagesPath/menu.svg';
  String get wishlist => '$kSvgImagesPath/heart.svg';
  String get edit => '$kSvgImagesPath/edit.svg';
  String get myprofile => '$kSvgImagesPath/myprofile.svg';
  String get right_arrow => '$kSvgImagesPath/right_arrow.svg';
  String get privacy_policy => '$kSvgImagesPath/privacy_policy.svg';
  String get help_support => '$kSvgImagesPath/help_support.svg';
  String get unlock => '$kSvgImagesPath/unlock.svg';
  String get my_address => '$kSvgImagesPath/my_address.svg';
  String get order => '$kSvgImagesPath/order.svg';
  String get logout => '$kSvgImagesPath/logout.svg';
  String get wishlist2 => '$kSvgImagesPath/wishlist2.svg';
  String get share => '$kSvgImagesPath/share.svg';
  String get star => '$kSvgImagesPath/star.svg';
  String get chat => '$kSvgImagesPath/chat.svg';
  String get cart => '$kSvgImagesPath/cart.svg';
}

class Assets {
  Assets._();
  static const images = _AssetsImagesGen();
  static const svgImages = _AssetsSvgImagesGen();
}