import 'package:prakriti_finder/Quiz/option.dart';

class OptionBrain {
  List<Option> optionlist = [
    Option('Medium', 'Thin and Lean', 'Well Built'),
    Option('Dry', 'Greasy', 'Normal'),
    Option('Black', 'Brown', 'Grey'),
    Option('Dry,Rough', 'Moist,Greasy', 'Soft,Sweating'),
    Option('Dark', 'Glowing', 'Pinkish'),
    Option('Normal', 'Overweight', 'Underweight'),
    Option('Blackish', 'Pinkish', 'Redish'),
    Option('Irregular,Blackish', 'Large,White', 'Medium,Yellowish'),
    Option('Fast', 'Medium', 'Slow'),
    Option('Aggressive', 'Restless', 'Stable'),
    Option('Good Memory', 'Long Term', 'Short term'),
    Option('Less', 'Moderate', 'Sleepy'),
    Option('Dislike Cold', 'Dislike Heat', 'Dislike Moist'),
    Option('Anger', 'Anxiety', 'Calm'),
    Option('Changes Quickly', 'Changes Slowly', 'Constant'),
    Option('Improper Chewing', 'Irregular Chewing', 'Proper Chewing'),
    Option('Irregular', 'Skips Meal', 'Sudden and Sharp'),
    Option('Less than Normal', 'More than Normal', 'Normal'),
    Option('Healthy', 'Heavy', 'Weak'),
    Option('Egoistic,Fearless', 'Forgiving,Grateful', 'Jealous,Fearful'),
    Option('High', 'Low', 'Medium'),
    Option('Deep', 'Fast', 'Rough'),
    Option('Fire', 'Sky', 'Water'),
    Option('Ambivert', 'Extrovert', 'Introvert'),
    Option('Mild', 'Negligible', 'Strong'),
  ];

  String getOptionText(int quesNo, int optionNo) {
    if (quesNo < optionlist.length) {
      if (optionNo == 0) {
        return optionlist[quesNo].option1Text;
      } else if (optionNo == 1) {
        return optionlist[quesNo].option2Text;
      } else if (optionNo == 2) {
        return optionlist[quesNo].option3Text;
      }
    }
    return "";
  }

  int getlength() {
    return optionlist.length;
  }
}