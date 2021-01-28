
class Student {

  final int id;
  final String username;
  final String name;
  final String surname;
  final String password;
  final int mark;
  final String quiz ;


  Student({
    this.id,
    this.username,
    this.name,
    this.surname,
    this.password,
    this.mark,
    this.quiz
});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'surname': surname,
      'password': password,
      'mark': mark,
      'quiz': quiz,

    };
    return map;
  }

  //  Student.fromMap(Map<String, dynamic> map) {
  //   id = map['id'];
  //   username = map['name'];
  //   name = map['id'];
  //   surname = map['name'];
  //   password = map['id'];
  //   mark = map['name'];
  //   quiz = map['name'];
  // }


  @override
  String toString() {
    return 'Student => id: $id, username: $username, name: $name , surname: $surname, password: $password, mark: $mark, quiz: $quiz';
  }
}