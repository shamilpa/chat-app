import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';
String?token;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.context, this.userEmail,this.name) : super(HomeInitial());
  BuildContext context;
  TextEditingController textCtr = TextEditingController();
  String userEmail;
  String name;

  
  storeData() async {

    FirebaseFirestore.instance
        .collection("message")
        .doc(token)
        .collection(userEmail)
        .add({
      "message": textCtr.text,
      "time": DateTime.now().toString(),
      "user":name,
      "sender_token":token
      
    });
    textCtr.clear();
  }
}
