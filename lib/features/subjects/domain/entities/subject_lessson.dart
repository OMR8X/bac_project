class SubjectLesson {
  // info
  String title;
  String unit;
  String material;
  // proprties
  SubjectLessonType type;
  // state
  bool done;
  bool studying;

  SubjectLesson({
    this.type = SubjectLessonType.lesson,
    required this.title,
    required this.unit,
    required this.material,
    this.done = false,
    this.studying = false,
  });
}

enum SubjectLessonType {
  lesson,
  exercises,
}
