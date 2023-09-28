part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperEvent {}
class ImageOfMonthEvent extends WallpaperEvent{
}
class SearchImageEvent extends WallpaperEvent{
  final String searchQuery;
  final String?color;
  final int?pageCount;
  SearchImageEvent({required this.searchQuery,this.color,this.pageCount});
}

