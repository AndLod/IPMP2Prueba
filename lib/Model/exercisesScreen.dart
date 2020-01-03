import 'package:flutter/material.dart';
import 'exerciseDetailScreen.dart';

class Exercise {
  String _name;
  Image _image;
  String _description;
  String _rep;
  String _video;
  Exercise(this._name, this._image, this._description, this._rep, this._video);
  String getName(){
    return this._name;
  }
  Image getImage(){
    return this._image;
  }
  String getDescription(){
    return this._description;
  }
  String getRep(){
    return this._rep;
  }
  String getVideo(){
    return this._video;
  }
}

class ExercisesFrame extends StatefulWidget {
  Future<List<Exercise>>  listaejercicios;
  String workoutName;
  ExercisesFrame(this.listaejercicios, this.workoutName);
  @override
  State<StatefulWidget> createState() => _ExerciseFrameState(this.listaejercicios, this.workoutName);

}
class _ExerciseFrameState extends State<ExercisesFrame> {
  Future<List<Exercise>>  listaejercicios;
  String workoutName;
  _ExerciseFrameState(this.listaejercicios, this.workoutName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.workoutName),
        ),
        body: ExercisesList(this.listaejercicios)
    );
  }
}

Widget ExercisesList(Future<List<Exercise>> listaejercicios){
  return new  FutureBuilder(
      future: listaejercicios,
      builder: (BuildContext context, lista) {
        if (!lista.hasData)
          return new Align(
              child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),),
              alignment: FractionalOffset.center
          );

        List<Exercise> content = new List<Exercise>();
        content = lista.data;
        return new ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: content.length,
          itemBuilder: (BuildContext context, int index){
            if(content.elementAt(index).getName()!='rest'){
              return new Card(child: ListTile(
                onTap: () { Navigator.push( context,
                  MaterialPageRoute(builder: (context) => ExerciseDetailFrame(content.elementAt(index))),);
                },
                leading: content.elementAt(index).getImage(),
                title: Text(content.elementAt(index).getName()),
                subtitle: Text(content.elementAt(index).getRep())
              )
              );
            }else{
              return new Card(child: ListTile(
                onTap: () {},
                leading: content.elementAt(index).getImage(),
                title: Text(content.elementAt(index).getName()),
                subtitle: Text(content.elementAt(index).getRep())
              )
              );
            }
            
          },
        );
      }
  );
}