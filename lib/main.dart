import 'package:flutter/material.dart';
import 'package:ipm_p2/Model/workoutScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ipm_p2/Model/DBConection.dart';

// void main() => runApp(MyApp());

void main() => runApp(MyApp());

DBConnection conModel = DBConnection(); 

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ScopedModel<DBConnection>(
      model: conModel,
      child: MaterialApp(
        title: 'IPM-p2',
        home: WorkoutFrame(DBConnection.getWorkoutList()),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightGreenAccent,
          accentColor: Colors.lightGreenAccent,
        )
      )
    );
  }
}