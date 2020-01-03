import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'DBConection.dart';
import 'exercisesScreen.dart';

class Workout{
  String _name;
  Image _image;
  DateTime _date;
  String _description;
  List<Exercise> _exercisesList;
  Workout(this._name, this._image, this._description, this._exercisesList){
    this._date= DateTime.now();
  }

  String getName(){
    return this._name;
  }
  Image getImage(){
    return this._image;
  }
  DateTime getDate(){
    return this._date;
  }
  String getDescription(){
    return this._description;
  }
  List<Exercise> getExercisesList(){
    return this._exercisesList;
  }
}

class WorkoutFrame extends StatefulWidget {
  Future<List<Workout>> listarutinas;
  WorkoutFrame(this.listarutinas);
  @override
  State<StatefulWidget> createState() => _WorkoutFrameState(this.listarutinas);

}

class _WorkoutFrameState extends State<WorkoutFrame> {
  Future<List<Workout>> listarutinas;

  _WorkoutFrameState(this.listarutinas);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IPM-p2"),
        ),
        body: WorkoutList(this.listarutinas)
    );
  }
}


Widget WorkoutList(Future<List<Workout>> listarutinas){
  return new  FutureBuilder(
      future: listarutinas,
      builder: (BuildContext context, lista) {
        if (!lista.hasData)
          return new Align(
              child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),),
              alignment: FractionalOffset.center
          );

        List<Workout> content = new List<Workout>();
        content = lista.data;
        return new ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: content.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(child: ListTile(
              onTap: () { Navigator.push( context,
                MaterialPageRoute(builder: (context) => ExercisesFrame(DBConnection.getExerciseList(content.elementAt(index)),content.elementAt(index).getName() )),);
              },
              leading: content.elementAt(index).getImage(),
              title: Text(content.elementAt(index).getName()),
              subtitle: Text(formatDate(content.elementAt(index).getDate(),[mm,'-',dd,'-',yyyy])),
            )
            );
          },
        );
      }
  );
}