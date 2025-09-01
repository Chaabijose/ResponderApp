import '../models/api/pagination_data.dart';
import 'base_controller.dart';
import 'base_repository.dart';
import 'swipable_refresh.dart';

abstract class SwipeableController<R extends BaseRepository>
    extends BaseController<R> {
  ///Data ********************
  var refreshController = FRefreshController();
  bool footerEnabled = true;

  // Pagination fields ***
  PaginationData? paginationData = PaginationData();

  /// Lifecycle methods ***************
  @override
  void onInit() {
    setRefreshListeners();
    paginationEnabled(true);
    super.onInit();
  }

  ///Logic *************************
  void setRefreshListeners() {
    refreshController.setOnStateChangedCallback((state) {
      if (state == RefreshState.refreshing) {
        _onRefresh();
      } else if (state == LoadState.loading) {
        loadMore();
      }
    });
  }

  void paginationEnabled(bool enabled) {
    footerEnabled = enabled;
    update();
  }

  void triggerRefresh() {
    _scrollToUp();
    refreshController.refresh();
  }

  void _scrollToUp() {
    refreshController.scrollTo(0, duration: const Duration(milliseconds: 200));
  }

  void _onRefresh() {
    stopLoading();
    return;
    // resetPagination();
    // onRefresh();
  }

  void resetPagination() {
    paginationData = PaginationData();
    paginationEnabled(true);
  }

  void setNextPage({required int totalItems,required int currentItems}) {
    if(totalItems > currentItems){
      paginationData?.page = paginationData!.page! + 1 ;
    }else{
      resetPagination();
      paginationEnabled(false);
    }
    // paginationData?.page = currentPage + 1;
  }

  @override
  stopLoading() {
    super.stopLoading();
    refreshController.finishRefresh();
    refreshController.finishLoad();
  }

  /// Abstract methods *****
  onRefresh();

  loadMore();

  ///Dispose
  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
