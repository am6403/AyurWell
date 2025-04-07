import 'package:prakriti_finder/Quiz/question.dart';


class QuizBrain {
  List<Question> questionlist = [
    Question('What is your body frame?'),
    Question('What is your hair type?'),
    Question('What is the color of your hair?'),
    Question('How would you describe your skin?'),
    Question('What is your complexion like?'),
    Question('What is your body weight like?'),
    Question('How do your nails look?'),
    Question('What is the size and color of your teeth?'),
    Question('How is your pace of performing work?'),
    Question('How is your mental activity?'),
    Question('How is your memory?'),
    Question('What is your sleep pattern like?'),
    Question('How do you feel in different weather conditions?'),
    Question('How do you react under adverse situations?'),
    Question('How is your mood usually?'),
    Question('How would you describe your eating habits?'),
    Question('How often do you feel hungry?'),
    Question('How is your body temperature?'),
    Question('How do your joints feel?'),
    Question('What is your general nature?'),
    Question('How is your body energy level?'),
    Question('How would you describe the quality of your voice?'),
    Question('What kind of dreams do you usually have?'),
    Question('How are your social relations?'),
    Question('How is your body odor?'),
  ];



  String getQuestionText(int quesNo) {
    if (quesNo < questionlist.length) {
      return questionlist[quesNo].questionText;
    } else {
      return "";
    }
  }

  int getlength() {
    return questionlist.length;
  }

  int getQuestionCount() {
    return questionlist.length;
  }
}