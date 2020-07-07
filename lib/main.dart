import 'package:flutter/material.dart';
import 'package:udemy/models/student.dart';
import 'package:udemy/screens/student_add.dart';
import 'package:udemy/screens/students_edit.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = "";

  Student selectedStudent = Student.withId(0, "", "", 0);

  List<Student> students = [
    Student.withId(1, "Hasan Ali", "Şişeci", 60),
    Student.withId(2, "Engin", "Demirog", 25),
    Student.withId(3, "Kerem", "Varış", 45)
  ];

  var ogrenciler = ["Hasan Ali1", "Hasan Ali2", "Hasan Ali3", "Hasan Ali4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Takip Sistemi"),
      ),
      body: buildBody(context),
    );
  }

  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("Silindi"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2100&q=80"),
                    ),
                    title: Text(students[index].firstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Sınavdan alınan not : " +
                        students[index].grade.toString() +
                        " [" +
                        students[index].getStatus +
                        "] "),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: () {
                      //Build işlemini çalıştırıp içindeki kodu kim kullanıyorsa yeniden çalıştırır.
                      setState(() {
                        selectedStudent = students[index];
                      });
                      print(selectedStudent.firstName +
                          " " +
                          selectedStudent.lastName);
                    },
                  );
                })),
        Text("Secili Ogrenci : " +
            selectedStudent.firstName +
            " " +
            selectedStudent.lastName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: RaisedButton(
                color: Colors.orange,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.add),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text("Ekle"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentAdd(students)))
                        .then((value) => setState(() {}));
                  });
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: RaisedButton(
                color: Colors.orange,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.update),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StudentEdit(selectedStudent)))
                        .then((value) => setState(() {}));
                  });
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: RaisedButton(
                color: Colors.orange,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.delete),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                  });
                  var mesaj = "Silindi : " +
                      selectedStudent.firstName +
                      " " +
                      selectedStudent.lastName;
                  mesajGoster(context, mesaj);
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.refresh);
    } else {
      return Icon(Icons.clear);
    }
  }
}
