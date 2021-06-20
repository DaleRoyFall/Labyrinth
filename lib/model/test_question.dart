class TestQuestion {
  String question;
  String type;
  String disease;
  List<String> answers;
  List<int> answerPoints;
  List<String> correctAnswers;
  String inputHint;
  String imageUrl;

  TestQuestion({
    this.question,
    this.type,
    this.disease,
    this.answers,
    this.answerPoints,
    this.correctAnswers,
    this.inputHint,
    this.imageUrl,
  });
}
