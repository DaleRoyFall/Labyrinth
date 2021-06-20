import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labyrinth/firebase/enum/test_question_type.dart';
import 'package:labyrinth/firebase/firebase_cloud_firestore.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/helper/validation.dart';
import 'package:labyrinth/home/test/diagnosis_page.dart';
import 'package:labyrinth/home/test/widget/schizophrenia_optical_illusion.dart';
import 'package:labyrinth/login/widgets/input_field.dart';
import 'package:labyrinth/model/test_question.dart';
import 'package:labyrinth/firebase/firebase_authentification.dart';

import 'widget/demential_line_test.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController inputController = TextEditingController(text: "");
  String dementialLineResult;
  Map<String, int> diseaseScore = {
    "Dementia": 0,
    "Depression": 0,
    "Bipolar": 0,
    "Schizophrenia": 0,
  };

  int questionIndex = 0;
  List<TestQuestion> questions = [
    TestQuestion(
      question:
          "Do you wake up early and then sleep badly for the rest of the night?",
      type: "BUTTON",
      disease: "Depression",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Do you feel sad and miserable?",
      type: "BUTTON",
      disease: "Depression",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Have you lost interest in the things you enjoyed?",
      type: "BUTTON",
      disease: "Depression",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Do you feel guilty, slowed down, bad about yourself?",
      type: "BUTTON",
      disease: "Depression",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Are you thinking about death or suicide?",
      type: "BUTTON",
      disease: "Depression",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question:
          "Do you feeling overly happy or 'high' for long periods of time?",
      type: "BUTTON",
      disease: "Bipolar",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Do you speak very fast, often with racing thoughts?",
      type: "BUTTON",
      disease: "Bipolar",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Are you easily distracted?",
      type: "BUTTON",
      disease: "Bipolar",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Are you too confident in your abilities?",
      type: "BUTTON",
      disease: "Bipolar",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Are you feeling very anxious or impulsive?",
      type: "BUTTON",
      disease: "Bipolar",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question: "Draw a line from one circle to another(1 to A to 2 to B...)",
      type: "DEMENTIA_LINE",
      disease: "Dementia",
      answers: [
        "Done",
        "I don't know",
      ],
      correctAnswers: ["1A2B3C4D5E"],
    ),
    TestQuestion(
      question: "What country are you from?",
      type: "INPUT",
      disease: "Dementia",
      answers: [
        "Done",
        "I don't know",
      ],
      correctAnswers: ["{user.country}"],
      inputHint: "Written at registration",
    ),
    TestQuestion(
      question: "Do you have daily thinking and/or memory problems?",
      type: "BUTTON",
      disease: "Dementia",
      answers: [
        "No, not at all",
        "No, not much",
        "Yes, sometimes",
        "Yes, definitely"
      ],
      answerPoints: [0, 1, 2, 3],
    ),
    TestQuestion(
      question:
          "You are buying \$3.85 of groceries. How much change should you receive from a \$7 note?",
      type: "INPUT",
      disease: "Dementia",
      answers: [
        "Done",
        "I don't know",
      ],
      correctAnswers: ["3.15"],
      inputHint: "Enter a number",
    ),
    TestQuestion(
      question: "How many 5p coins would it take to pay 45p?",
      type: "INPUT",
      disease: "Dementia",
      answers: [
        "Done",
        "I don't know",
      ],
      correctAnswers: ["9"],
      inputHint: "Enter a number",
    ),
    TestQuestion(
      question: "Do you ever hear or see things that others cannot?",
      type: "BUTTON",
      disease: "Schizophrenia",
      answers: [
        "Never",
        "Rarely",
        "Sometimes",
        "Often",
        "Very Often",
      ],
      answerPoints: [0, 1, 2, 3, 4],
    ),
    TestQuestion(
      question:
          "Do you struggle to keep up with daily living tasks such as showering, changing clothes, paying bills, cleaning, cooking, etc.?",
      type: "BUTTON",
      disease: "Schizophrenia",
      answers: [
        "Never",
        "Rarely",
        "Sometimes",
        "Often",
        "Very Often",
      ],
      answerPoints: [0, 1, 2, 3, 4],
    ),
    TestQuestion(
      question: "Choose the right pattern",
      type: "SCHIZOPHRENIA_OPTICAL_ILLUSION",
      disease: "Schizophrenia",
      answers: [
        "Done",
        "I don't know",
      ],
      inputHint: "Enter a number",
      imageUrl: "assets/images/test/schizoprenia-optical-illusion-test-3.jpg",
      correctAnswers: ["1"],
    ),
    TestQuestion(
      question:
          "Do other people say that it is difficult for you to stay on subject or for them to understand you?",
      type: "BUTTON",
      disease: "Schizophrenia",
      answers: [
        "Never",
        "Rarely",
        "Sometimes",
        "Often",
        "Very Often",
      ],
      answerPoints: [0, 1, 2, 3, 4],
    ),
    TestQuestion(
      question: "Choose the right pattern",
      type: "SCHIZOPHRENIA_OPTICAL_ILLUSION",
      disease: "Schizophrenia",
      answers: [
        "Done",
        "I don't know",
      ],
      inputHint: "Enter a number",
      imageUrl: "assets/images/test/schizoprenia-optical-illusion-test-2.jpg",
      correctAnswers: ["1"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
        alignment: Alignment.center,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: SizeConfig.adaptHeight(25),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.adaptWidth(10)),
                  child: Text(
                    questionIndex < questions.length
                        ? questions[questionIndex].question
                        : "",
                    style: TextStyle(
                        fontSize: SizeConfig.adaptFontSize(6),
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.adaptHeight(4),
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                _buildAnswerList(questions[questionIndex]),
              ),
            )
          ],
        ));
  }

  _buildAnswerList(TestQuestion question) {
    List<Widget> answerWidgets = [];

    if (question.type ==
        typeToString(TestQuestionType.DEMENTIA_LINE.toString())) {
      answerWidgets.add(DepentialLineTest(onChanged: (String result) {
        dementialLineResult = result;
        print(dementialLineResult);
      }));
      answerWidgets.add(SizedBox(
        height: SizeConfig.adaptHeight(4),
      ));
    }

    if (question.type ==
        typeToString(
            TestQuestionType.SCHIZOPHRENIA_OPTICAL_ILLUSION.toString())) {
      answerWidgets.add(SchizophreniaOpticalIllusion(
        imageUrl: question.imageUrl,
      ));
      answerWidgets.add(SizedBox(
        height: SizeConfig.adaptHeight(4),
      ));
    }

    if (question.type == typeToString(TestQuestionType.INPUT.toString()) ||
        question.type ==
            typeToString(
                TestQuestionType.SCHIZOPHRENIA_OPTICAL_ILLUSION.toString())) {
      answerWidgets.add(
        InputField(
          Colors.deepPurple[700].withOpacity(0.5),
          question.inputHint,
          Icons.title,
          inputController,
          validateField,
          false,
          TextInputType.visiblePassword,
        ),
      );
      answerWidgets.add(SizedBox(
        height: SizeConfig.adaptHeight(4),
      ));
    }

    for (int i = 0; i < question.answers.length; i++) {
      answerWidgets.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.adaptWidth(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue[900].withOpacity(0.3))),
              onPressed: () {
                // DEMENTIA_LINE
                if (question.type ==
                    typeToString(TestQuestionType.DEMENTIA_LINE.toString())) {
                  if (!question.correctAnswers.contains(dementialLineResult)) {
                    diseaseScore[question.disease] += 5;
                  }
                }

                // BUTTON
                if (question.type ==
                    typeToString(TestQuestionType.BUTTON.toString())) {
                  diseaseScore[question.disease] += question.answerPoints[i];
                }

                // INPUT
                if (question.type ==
                        typeToString(TestQuestionType.INPUT.toString()) ||
                    question.type ==
                        typeToString(TestQuestionType
                            .SCHIZOPHRENIA_OPTICAL_ILLUSION
                            .toString())) {
                  if (question.correctAnswers[0].startsWith("{") &&
                      question.correctAnswers[0].endsWith("}")) {
                    if (question.correctAnswers[0] == "{user.country}") {
                      if (!(inputController.text ==
                          FirebaseCloudFirestore.currUserInfo["country"])) {
                        diseaseScore[question.disease] += 3;
                      }
                    }
                  } else if (!question.correctAnswers
                      .contains(inputController.text.toString())) {
                    diseaseScore[question.disease] += 3;
                  }
                }

                print(diseaseScore);
                print(question.answers[i]);

                if (questionIndex + 1 == questions.length) {
                  List<MapEntry<String, int>> sortedDiseases =
                      diseaseScore.entries.toList();
                  sortedDiseases
                      .sort((frst, scnd) => frst.value.compareTo(scnd.value));
                  String disease = sortedDiseases.last.key;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DiagnosisPage(disease: disease)),
                  );
                } else {
                  setState(() {
                    questionIndex++;
                  });
                }

                inputController.clear();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.adaptHeight(2),
                    horizontal: SizeConfig.adaptWidth(5)),
                child: Text(
                  question.answers[i],
                  style: TextStyle(
                    fontSize: SizeConfig.adaptFontSize(5),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      answerWidgets.add(
        SizedBox(
          height: SizeConfig.adaptHeight(1),
        ),
      );
    }

    return answerWidgets;
  }

  String typeToString(String type) {
    return type.substring(type.indexOf(".") + 1);
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
