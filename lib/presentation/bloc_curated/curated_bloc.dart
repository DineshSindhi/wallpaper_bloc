import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_bloc/presentation/bloc_curated/curated_event.dart';
import 'package:wallpaper_bloc/presentation/bloc_curated/curated_state.dart';
import 'package:wallpaper_bloc/presentation/get_api/api_key.dart';

import '../../data/model/data_model.dart';
import '../get_api/api.dart';
class CuratedBloc extends Bloc<CuratedEvent,CuratedState>{
  ApiHelper apiHelper;
  CuratedBloc({required this.apiHelper}):super(CuratedInitState()){
    on<CuratedWall>((event, emit) async {
     emit( CuratedLoadingState());
     try{
       var mData= await apiHelper.getApiWallpaper(url: GetApiKey.CURATED_API);
       var rawData=DataModel.fromJson(mData);
       emit(CuratedLoadedState(photoModel: rawData));

     }catch(e){
       emit(CuratedErrorState(msg: (e.toString())));
     }
    });
  }
}
