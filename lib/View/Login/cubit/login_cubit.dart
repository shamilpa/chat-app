import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/View/Home%20Page/cubit/home_cubit.dart';
import 'package:firebase_project/View/Users%20List/user_list.dart';
import 'package:firebase_project/local_storage.dart';
import 'package:firebase_project/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../Home Page/homepage.dart';

part 'login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.context) : super(AuthInitial()) {
    // value=1;
  }

  BuildContext context;
  bool value = true;
  cliked() {
    value = !value;
    emit(AuthInitial());
  }

  TextEditingController usrName = TextEditingController();
  TextEditingController passWord = TextEditingController();

  login() async {
    if (usrName.text.isNotEmpty && passWord.text.isNotEmpty) {
      try {
        UserCredential? users = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: usrName.text.trim(), password: passWord.text.trim());
        if (users.user != null) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(users.user!.uid.toString());
          token = users.user!.uid;
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashScreen(),));
      } on FirebaseException catch (e) {
        print(e.code);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Field is empty")));
    }
  }
}
