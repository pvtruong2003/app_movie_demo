class BaseResponse<T> {
  int page;
  int totalResults;
  int totalPages;
  String error;

  BaseResponse({this.page, this.totalResults, this.totalPages, this.error});

  BaseResponse.fromJson(Map<String, dynamic> js) {
    page = js['page'];
    totalResults = js['total_results'];
    totalPages = js['total_pages'];
  }

  BaseResponse.withError(String error): error = error;

}
