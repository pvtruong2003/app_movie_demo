class ResponseRating {
  final int statusCode;
  final String statusMessage;
  final bool success;

  ResponseRating(this.statusCode, this.statusMessage, this.success);

  factory ResponseRating.fromJson(Map<String, dynamic> js) {
    return ResponseRating(
        js['status_code'], js['status_message'], js['success']);
  }
}