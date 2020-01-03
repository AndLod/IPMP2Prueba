import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'workoutScreen.dart';
import 'exercisesScreen.dart';

class DBConnection extends Model{

  var no_image = new Image.network(
      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.se6duPKpArNz0YnywnnYHQHaHa%26pid%3DApi&f=1');
  
  var rest_image = new Image.network('https://darebee.com/images/fitness/rest-days.jpg');
  static DBConnection _instance;
  mongo.Db db;
  
  static Future<List<Workout>> getWorkoutList() {        
    if (_instance == null)
      _instance = DBConnection();
    return _instance.getWorkouts();
  }

  static Future<List<Exercise>> getExerciseList(Workout workout) {    
    if (_instance == null)
      _instance = DBConnection();
    return _instance.getExercises(workout);
  }


  Future<List<Workout>> getWorkouts() async {
    mongo.Db db = new mongo.Db(
        "mongodb://uonrdogxvz0lcgp7gwlz:PnIIJpLbgQ8WevVlzRib@behnpygv0o2k4al-mongodb.services.clever-cloud.com:27017/behnpygv0o2k4al");
    await db.open();

    List<Workout> workoutList = new List<Workout>();  
    List<Exercise> listaEjercicios;  
    var workoutdb = db.collection('workouts').find();

    await for (var workout in workoutdb) {
      var name = workout['name'].toString();
      var description = workout['description'].toString().replaceAll('[', '').replaceAll(']', '');    
      var image;
      var exercisesList = (workout['exercises']);
      if (workout['image'] != '') {       
        image = Image.memory(base64Decode(utf8.decode(workout['image'].byteList)));
       
      }else{
        image = no_image;
      }
      
      listaEjercicios = new List<Exercise>();
      for (int i = 0; i < exercisesList.length; i++) {
        var ejer_rep = exercisesList[i];
        listaEjercicios.add(
            new Exercise(ejer_rep[0], null, null, ejer_rep[1], null));
      }

      workoutList.add(new Workout(name, image, description, listaEjercicios));
    }
    return workoutList;
  }


  Future<List<Exercise>> getExercises(Workout workout) async {
    mongo.Db db = new mongo.Db(
        "mongodb://uonrdogxvz0lcgp7gwlz:PnIIJpLbgQ8WevVlzRib@behnpygv0o2k4al-mongodb.services.clever-cloud.com:27017/behnpygv0o2k4al");
    await db.open();
    List<Exercise> listaEjercicios;
    var exercisedb = db.collection('exercises');

    listaEjercicios = new List<Exercise>();
    for (int i = 0; i < workout
        .getExercisesList()
        .length; i++) {
      var ejer_rep = workout.getExercisesList().elementAt(i);
      if (ejer_rep.getName() != "rest") {
        await for (var exercise in exercisedb.find(
            {'name': ejer_rep.getName()})) {
          var exername = exercise['name'];
          var contExerDesc = exercise['description'].toString().toString().replaceAll('[', '').replaceAll(']', '');          
          if (contExerDesc==''){
            contExerDesc = "No description data";
          }
          var exerdesc = contExerDesc;          
          var numRep = ejer_rep.getRep();
          var image;
          var video = exercise['video'];
          if(exercise['image']!=''){
            image = Image.memory(base64Decode(utf8.decode(exercise['image'].byteList)));
          }else{
            image = no_image;
          }
          listaEjercicios.add(
              new Exercise(exername, image, exerdesc, numRep, video));
        }
      } else {
        listaEjercicios.add(
            new Exercise(ejer_rep.getName(), rest_image, "", ejer_rep.getRep(), null));
      }
    }
    return listaEjercicios;
  }

}