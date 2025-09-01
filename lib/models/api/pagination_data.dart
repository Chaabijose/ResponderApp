
class PaginationData {
  int? page;
  int? totalItems;

  bool get isLastPage => totalItems != null && page! >= totalItems!;

  PaginationData({this.page = 1,this.totalItems});
}
