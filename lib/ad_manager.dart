import 'package:json_annotation/json_annotation.dart';

part 'ad_manager.g.dart';

@JsonSerializable()
class AdManager {
  final String? adNetwork;
  final String? interstitialAdmob;
  final String? bannerAdmob;
  final String? nativeAdmob;
  final String? interstitialFan;
  final String? bannerFan;
  final String? nativeFan;

  AdManager({
    this.adNetwork,
    this.interstitialAdmob,
    this.bannerAdmob,
    this.nativeAdmob,
    this.interstitialFan,
    this.bannerFan,
    this.nativeFan,
  });

  factory AdManager.fromJson(Map<String, dynamic> json) => _$AdManagerFromJson(json);
  Map<String, dynamic> toJson() => _$AdManagerToJson(this);
}
