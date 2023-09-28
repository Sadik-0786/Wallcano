part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperState {}

class WallpaperInitial extends WallpaperState {}
class WallpaperLoadingState extends WallpaperState{}
class WallpaperLoadedState extends WallpaperState{
  final ImgData images;
  WallpaperLoadedState({required this.images});
}
class WallpaperErrorState extends WallpaperState{
   final String errorMessage;
  WallpaperErrorState({required this.errorMessage});
}