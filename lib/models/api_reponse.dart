class ApiReponse<T>{
  T data;
  bool error;
  String errorMessage;
  ApiReponse({this.data, this.errorMessage, this.error=false});
}