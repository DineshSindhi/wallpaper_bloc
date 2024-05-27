abstract class SearchEvent{}
class SearchWallpaper extends SearchEvent{
  String query;
  String Color;
  int page;

  SearchWallpaper({required this.query,required this.Color,this.page=1});
}