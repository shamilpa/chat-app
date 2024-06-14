import 'package:firebase_project/View/Login/login_page.dart';
import 'package:firebase_project/View/Register/cubit/register_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Register Page'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(context),
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            final cubit = context.read<RegisterCubit>();
            return Center(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: cubit.name,
                            decoration: const InputDecoration(
                                hintText: 'Full Name',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: cubit.email,
                            decoration: const InputDecoration(
                                hintText: 'email',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: cubit.passWord,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.remove_red_eye),
                                hintText: 'password',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: cubit.confPass,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.remove_red_eye),
                                hintText: 'confirm password',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 50.0),
                          InkWell(
                              onTap: () {
                                cubit.register();
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.redAccent,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Submit",
                                )),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                              },
                              child: Text("Login"))
                        ],
                      ),
                    )));
          },
        ),
      ),
    );
  }
}
