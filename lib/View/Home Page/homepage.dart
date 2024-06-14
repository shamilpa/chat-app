import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/local_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

import '../Users List/user_list.dart';
import 'cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.userEmail, required this.name});
  final String userEmail;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          leading: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserList(),
                ));
              },
              child: Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 221, 221, 221),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("message")
                .doc(token) //change to token
                .collection(userEmail)
                .orderBy("time", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var sender = snapshot.data!.docs;
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("message")
                        .doc(userEmail)
                        .collection(token!)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var receiver = snapshot.data!.docs;
                      List storeValues = List.from(sender)..addAll(receiver);
                      storeValues.sort(
                        (a, b) {
                          var firstMsg = DateTime.parse(a["time"]);
                          var secondMsg = DateTime.parse(b["time"]);
                          return firstMsg.compareTo(secondMsg);
                        },
                      );
                      print(storeValues);
                      return BlocProvider(
                          create: (context) =>
                              HomeCubit(context, userEmail, name),
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              final cubit = context.read<HomeCubit>();
                              return Column(children: [
                                Expanded(
                                  flex: 1,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: BubbleSpecialThree(
                                            text: storeValues[index]["message"],
                                            color: Colors.white,
                                            isSender: token ==
                                                    storeValues[index]
                                                        ["sender_token"]
                                                ? true
                                                : false,
                                          ));
                                      // child:  ListTile(
                                      //   title:
                                      //       Text(storeValues[index]["message"]),
                                      //   tileColor: Colors.blue,
                                      // )
                                      // );
                                    },
                                    itemCount: storeValues.length,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: cubit.textCtr,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      hintText: "type here...",
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.send),
                                        onPressed: () {
                                          cubit.storeData();
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ]);
                            },
                          ));
                    });
              }
            }));
  }
}
