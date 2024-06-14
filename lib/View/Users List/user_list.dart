import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/View/Home%20Page/cubit/home_cubit.dart';
import 'package:firebase_project/View/Login/login_page.dart';
import 'package:firebase_project/local_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Home Page/homepage.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Chat List"),
          actions: [IconButton(onPressed:
          () {
            LocalStorage.deleteData();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(),));
          }, 
           icon: Icon(Icons.logout))],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("user").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async{
                            token=await LocalStorage.getData();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(
                                userEmail: snapshot.data!.docs[index]["user_id"],
                                name: snapshot.data!.docs[index]["name"],
                              ),
                            ));
                          },
                          child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]["name"],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
