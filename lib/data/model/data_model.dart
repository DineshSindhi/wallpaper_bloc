import 'package:wallpaper_bloc/data/model/photo_model.dart';

class DataModel{
  String?next_page;
  int?page;
  int?per_page;
  int?total_results;
  List<PhotoModel>?photos;

  DataModel({
    required this.next_page,
    required this.page,
    required this.per_page,
    required this.total_results,
    required this.photos
  });
  factory DataModel.fromJson(Map<String,dynamic>json){
    List<PhotoModel>mData=[];
    for(Map<String,dynamic>each in json['photos']){
      mData.add(PhotoModel.fromJson(each));
    }
    return DataModel(
      next_page: json['next_page'],
      page: json['page'],
      per_page: json['per_page'],
      total_results: json['total_results'],
      photos: mData,
    );
  }
}