class Student {
  int id;
  String firstName;
  String lastName;
  int grade;
  String _status;

  Student.withId(int id, String firsName, String lastName, int grade) {
    this.id = id;
    this.firstName = firsName;
    this.lastName = lastName;
    this.grade = grade;
  }

  Student(String firsName, String lastName, int grade) {
    this.firstName = firsName;
    this.lastName = lastName;
    this.grade = grade;
  }

  Student.withoutInfo() {}

  String get getStatus {
    if (this.grade >= 50) {
      _status = "Dersten Geçti";
    } else if (this.grade >= 40) {
      _status = "Büt'e Kaldı";
    } else {
      _status = "Dersten Kaldı";
    }
    return _status;
  }
}
