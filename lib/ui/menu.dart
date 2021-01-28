import 'package:flutter/material.dart';
import './quiz1.dart';
import './quiz2.dart';
import './quiz3.dart';
import 'package:nolik/database/database.dart';



void main(){
  runApp(
      new MaterialApp(
        home: new AnimalQuiz(),
      )
  );
}

class AnimalQuiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return new AnimalQuizState();
  }
}

class AnimalQuizState extends State<AnimalQuiz>{


  MyDatabase db = MyDatabase() ;
  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     appBar: new AppBar(
       title: new Text("Nolik learning app"),
       backgroundColor: Colors.blue,
     ),


     body: new Container(
          margin: const EdgeInsets.all(15.0),
       child: new Column(
          
         crossAxisAlignment: CrossAxisAlignment.stretch,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: new MaterialButton(
               height: 50.0,
                 color: Colors.green,
                 onPressed: startQuiz,

                 child: new Text("I.T Quiz",
                   style: new TextStyle(
                       fontSize: 18.0,
                       color: Colors.white
                   ),)
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: new MaterialButton(
                 height: 50.0,
                 color: Colors.green,
                 onPressed: startQuiz2,

                 child: new Text("Animal Quiz",
                   style: new TextStyle(
                       fontSize: 18.0,
                       color: Colors.white
                   ),)
             ),
           ),Padding(
             padding: const EdgeInsets.all(8.0),
             child: new MaterialButton(
                 height: 50.0,
                 color: Colors.green,
                 onPressed: startQuiz3,

                 child: new Text("Fruit Quiz",
                   style: new TextStyle(
                       fontSize: 18.0,
                       color: Colors.white
                   ),)
             ),
           )
         ],
       ),
     ),


   );
  }

  void startQuiz(){
   setState(() async {


     Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Quiz1()));
   });
  }

  void startQuiz2(){
    setState(() {
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Quiz2()));
    });
  }


  void startQuiz3(){
    setState(() {
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Quiz3()));
    });
  }
}

