import 'package:wallpaper_bloc/data/model/data_model.dart';
abstract class CuratedState{}
class CuratedInitState extends CuratedState{}
class CuratedLoadingState extends CuratedState{}
class CuratedLoadedState extends CuratedState{
  DataModel photoModel;
  CuratedLoadedState({required this.photoModel});
}
class CuratedErrorState extends CuratedState{
  String msg;
  CuratedErrorState({required this.msg});
}
