import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'exercisesScreen.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class ExerciseDetailFrame extends StatefulWidget {
  Exercise ejercicio;
  ExerciseDetailFrame(this.ejercicio);
  @override
  State<StatefulWidget> createState() => _ExerciseDetailFrame(this.ejercicio);

}
class _ExerciseDetailFrame extends State<ExerciseDetailFrame> {
   Exercise ejercicio;

  _ExerciseDetailFrame(this.ejercicio);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ejercicio.getName()),
        ),
        body: ExerciseLayout(context,this.ejercicio)
    );
  }
}

Widget ExerciseLayout(context, Exercise ejercicio){
  return new Column(crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.25,
          decoration: BoxDecoration(
            image: DecorationImage(image: new NetworkImage('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fbanner2.kisspng.com%2F20180320%2Froq%2Fkisspng-youtube-computer-icons-logo-clip-art-classic-youtube-icon-5ab1bdde3bbf41.4990002615215979182447.jpg&f=1&nofb=1'
            ))
          ),
          child: new FlatButton(
          onPressed: (){ VideoPlayer(ejercicio.getVideo());},
          child: null),
        ),

        Card(
            child:Text(
                ejercicio.getDescription(),
                textScaleFactor: 1.0,
                style: TextStyle(fontStyle: FontStyle.italic,
                    fontSize:MediaQuery.of(context).textScaleFactor*17)
            )
        )
      ]
  );
}


Widget VideoPlayer(String link) {
  return Center(
      child: FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "<API_KEY>",
          videoUrl: link,
          autoPlay: true, //default falase
          fullScreen: false //default false          
      )
  );
}
