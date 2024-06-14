import 'package:firebase_project/View/Login/cubit/login_cubit.dart';
import 'package:firebase_project/View/Register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login Page'),
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(context),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            return Center(
              child: AnimatedPadding(
                duration: Duration(seconds: 3),
                padding: EdgeInsets.all(cubit.value ? 15 : 150),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: cubit.usrName,
                        decoration: const InputDecoration(
                            hintText: 'Username', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: cubit.passWord,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.remove_red_eye),
                            hintText: 'Password',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 50.0),
                      InkWell(
                        onTap: () {
                          cubit.login();
                          // cubit.cliked();
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
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                          },
                          child: Text("Register"))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
