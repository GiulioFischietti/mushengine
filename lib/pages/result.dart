class ImageResult {
  String file_class;
  String file_name;

  ImageResult(data) {
    this.file_class = data['file_class'];
    this.file_name = data['file_name'];
  }
}
