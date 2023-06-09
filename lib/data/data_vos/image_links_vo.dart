import 'package:json_annotation/json_annotation.dart';

part 'image_links_vo.g.dart';

@JsonSerializable()
class ImageLinksVO{

  @JsonKey(name: "smallThumbnail")
  String? smallThumbnail;

  @JsonKey(name: "thumbnail")
  String? thumbnail;

  ImageLinksVO(this.smallThumbnail, this.thumbnail);

  factory ImageLinksVO.fromJson(Map<String, dynamic> json) => _$ImageLinksVOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageLinksVOToJson(this);

}