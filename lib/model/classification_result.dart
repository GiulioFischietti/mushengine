class ClassificationResult {
  String classname;
  double confidence;

  ClassificationResult(data) {
    this.classname = data['class'];
    this.confidence = data['confidence'];
  }
}
