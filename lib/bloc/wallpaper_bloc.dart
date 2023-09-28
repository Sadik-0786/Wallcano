import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallcano/app_const.dart';
import '../api_response/img_response.dart';
import '../model/image_data.dart';
part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ApiResponse apiResponse;
  WallpaperBloc({required this.apiResponse}) : super(WallpaperInitial()) {
    on<ImageOfMonthEvent>((event, emit) async {
      emit(WallpaperLoadingState());
     try{
       ImgData?res = await ApiResponse().getApi(
           '${AppConst.curatedImagesLink}?per_page=30');
       emit(WallpaperLoadedState(images: res!));
     }catch(exception){
       emit(WallpaperErrorState(errorMessage: exception.toString()));
     }

    });
    on<SearchImageEvent>((event, emit) async {
      emit(WallpaperLoadingState());
      try{
        ImgData?res = await ApiResponse().getApi(
            '${AppConst.searchQueryLink}?query=${event.searchQuery}&per_page=20&page=${event.pageCount}&&color=${event.color??''}');
        emit(WallpaperLoadedState(images: res!));
      }catch(exception){
        emit(WallpaperErrorState(errorMessage: exception.toString()));
      }
    });
  }
}
