import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_bloc/data/model/data_model.dart';
import 'package:wallpaper_bloc/presentation/bloc/search_event.dart';
import 'package:wallpaper_bloc/presentation/bloc/search_state.dart';
import 'package:wallpaper_bloc/presentation/get_api/api_key.dart';
import 'package:wallpaper_bloc/presentation/get_api/exception.dart';

import '../get_api/api.dart';
class SearchBloc extends Bloc<SearchEvent,SearchState>{
  ApiHelper apiHelper;
  SearchBloc({required this.apiHelper}):super(SInitState()){
    on<SearchWallpaper>((event, emit) async {
      emit(SLoadingState());
      try{
        var mData=await apiHelper.getApiWallpaper(url: '${GetApiKey.SEARCH_API}query=${event.query}&per_page=16&color=${event.Color}&page=${event.page}');
        var rawData=DataModel.fromJson(mData);
        emit(SLoadedState(mData: rawData));
      }catch(e){
        emit(SErrorState(msg: (e.toString())));
      }
    });
  }
}