// // import 'package:bloc/bloc.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebasesigninandlogin/login.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:meta/meta.dart';

// // part 'register_state.dart';

// // class RegisterCubit extends Cubit<RegisterState> {
// //   RegisterCubit(this.context) : super(RegisterInitial());
// //   final BuildContext context;
// //   final TextEditingController registeremailcontroller = TextEditingController();
// //   final TextEditingController registerpasswordcontroller = TextEditingController();
// //   final TextEditingController registerconfirmpasswordcontroller =
// //   TextEditingController();

// //    registerfuc() async {
// //     try {
// //       await FirebaseAuth.instance
// //           .createUserWithEmailAndPassword(
// //           email: registeremailcontroller.text.trim(),
// //           password: registerpasswordcontroller.text.trim())
// //           .then((value) async {
// //         await FirebaseFirestore.instance.collection("user1").add({"name":registeremailcontroller.text});//ithaan saanam.
// //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
// //       });
// //     } catch (c) {
// //       print(c.hashCode);
// //     }
// //   }

// //    datastore() async {
// //     String name = registeremailcontroller.text.trim() ?? '';
// //     if (name.isNotEmpty) {
// //       await FirebaseFirestore.instance.collection("name").add({
// //         "name": registeremailcontroller.text.trim(),
// //         "Time": DateTime.now(),
// //       });
// //     }
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebasesigninandlogin/homepage.dart';
// import 'package:flutter/material.dart';

// class Chatlist extends StatelessWidget {
//   const Chatlist({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("user1").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             return Expanded(
//               child: ListView.separated(
//                 separatorBuilder: (context, index) => SizedBox(
//                   height: 10,
//                 ),
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage(),));
//                   },
//                     child: ListTile(
//                       tileColor: Colors.blueAccent,
//                       leading: Row(
//                         children: [CircleAvatar()
//                          , Text(
//                             snapshot.data!.docs[index]["name"],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }