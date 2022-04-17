class ResultQuery {
  String file_name;
  String file_class;
  double distance;

  ResultQuery(data) {
    this.file_class = data['file_class'];
    this.file_name = ("http://565b-34-125-167-86.ngrok.io/static/Dataset/" +
        (data['file_name'] as String).split("Dataset/")[1]);
    this.distance = (double.parse(data['distance']));
  }
}
