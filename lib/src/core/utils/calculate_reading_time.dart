int calculateReadingTime(String content){

  int averageReadingTime=235;

 final totalWord = content.split(RegExp(r'\s+')).length;

  final calculateReadingTime=totalWord/averageReadingTime;

  return calculateReadingTime.ceil();

}