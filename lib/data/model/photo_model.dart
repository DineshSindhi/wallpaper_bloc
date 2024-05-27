class PhotoModel {
  String? photographer;
  bool? liked;
  int? id;
  int? width;
  int? height;
  int? photographer_id;
  String? photographer_url;
  String? avg_color;
  String? alt;
  String? url;
  SrcModel? src;

  PhotoModel(
      {required this.photographer,
        required this.liked,
        required this.id,
        required this.width,
        required this.height,
        required this.photographer_id,
        required this.photographer_url,
        required this.avg_color,
        required this.alt,
        required this.url,
        required this.src});

  factory PhotoModel.fromJson(Map<String, dynamic> json){
    var mData=SrcModel.fromJson(json['src']);
    return PhotoModel(
        photographer: json['photographer'],
        liked: json['liked'],
        id: json['id'],
        width: json['width'],
        height: json['height'],
        photographer_id: json['photographer_id'],
        photographer_url: json['photographer_url'],
        avg_color: json['avg_color'],
        alt: json['alt'],
        url: json['url'],
        src: mData);
  }
}

class SrcModel {
  String? landscape;
  String? large;
  String? large2x;
  String? medium;
  String? original;
  String? portrait;
  String? small;
  String? tiny;

  SrcModel(
      {required this.landscape,
        required this.large,
        required this.large2x,
        required this.medium,
        required this.original,
        required this.portrait,
        required this.small,
        required this.tiny});

  factory SrcModel.fromJson(Map<String, dynamic> json) {
    return SrcModel(
        landscape: json['landscape'],
        large: json['large'],
        large2x: json['large2x'],
        medium: json['medium'],
        original: json['original'],
        portrait: json['portrait'],
        small: json['small'],
        tiny: json['tiny']);
  }
}
