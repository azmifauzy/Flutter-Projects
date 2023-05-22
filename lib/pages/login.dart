import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qrcode/config/colors.dart';
import 'package:qrcode/bloc/bloc.dart';
import 'package:qrcode/routes/router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailC =
      TextEditingController(text: "admin@gmail.com");
  final TextEditingController passwordC =
      TextEditingController(text: "password");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Login"),
        // ),
        body: ListView(
      padding: EdgeInsets.all(20),
      children: [
        Lottie.asset("assets/anim.json"),
        Text(
          "OrenjiBox | Sign In",
          style: TextStyle(
              fontSize: 34,
              color: AppColors.primaryColor,
              fontFamily: "sans-serif",
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 25,
        ),
        TextField(
          autocorrect: false,
          controller: emailC,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        TextField(
          obscureText: true,
          autocorrect: false,
          controller: passwordC,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: AppColors.primaryColor),
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(AuthEventLogin(emailC.text, passwordC.text));
            },
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateLogin) {
                  context.goNamed(Routes.HOME);
                }
                if (state is AuthStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: AppColors.primaryColor,
                    content: Text(state.msg),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              builder: (context, state) {
                if (state is AuthStateLoading) {
                  return Text("Loading...",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500));
                }
                return Text("Login",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500));
              },
            ))
      ],
    ));
  }
}
