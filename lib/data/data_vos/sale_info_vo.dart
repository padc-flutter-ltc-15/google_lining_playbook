import 'package:json_annotation/json_annotation.dart';

part 'sale_info_vo.g.dart';

@JsonSerializable()
class SaleInfoVO{

  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "saleability")
  String? saleability;

  @JsonKey(name: "isEbook")
  bool? isEbook;

  SaleInfoVO(this.country, this.saleability, this.isEbook);


  factory SaleInfoVO.fromJson(Map<String, dynamic> json) => _$SaleInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$SaleInfoVOToJson(this);
}