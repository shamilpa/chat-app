import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../Users List/user_list.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.context) : super(RegisterInitial());

  BuildContext context;
  String? token;

  TextEditingController name = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confPass = TextEditingController();

  register() async {
    if (name.text.isNotEmpty && passWord.text.isNotEmpty) {
      try {
        UserCredential? users = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: passWord.text.trim());

        if (users.user != null) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(users!.user!.uid);

          token = users!.user!.uid;
          await FirebaseFirestore.instance.collection("user").add({
            "name": name.text,
            "user_id": users.user!.uid,
            "user_mail": email.text.trim()
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => UserList(),
          ));
        }

        // storeId() async {
        //   SharedPreferences sh = await SharedPreferences.getInstance();
        //   sh.setString("id", users!.user!.uid);
        // }

        // .then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
        //       builder: (context) => HomePage(),
        //     )));
      } on FirebaseException catch (e) {
        print(e.code);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Field is empty")));
    }
  }
}
