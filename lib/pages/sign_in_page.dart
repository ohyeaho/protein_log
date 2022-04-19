import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:protein_log/model/firebase_auth.dart';
import 'package:protein_log/pages/calendar_page.dart';
import 'package:protein_log/pages/sign_up_page.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Container(
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: '*メールアドレスは必須です'),
                    EmailValidator(errorText: '有効なメールアドレスを入力してください'),
                  ]),
                  decoration: InputDecoration(
                    labelText: 'メールアドレス',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xFFD1D1D1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                width: 300,
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: '*パスワードは必須です'),
                    MinLengthValidator(8, errorText: 'パスワードは8文字以上で入力してください'),
                    MaxLengthValidator(30, errorText: 'パスワードは30文字以内で入力してください'),
                    PatternValidator(r'(?=.*?[a-z])(?=.*?\d)[a-z\d](?=.*?[0-9])', errorText: '半角英数字をそれぞれ一種類以上含んでください'),
                  ]),
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xFFD1D1D1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 25.0,
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    //todo: 画面遷移
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                    // Navigator.pushReplacementNamed(context, "/signUp");
                  },
                  minWidth: 0,
                  height: 0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    'アカウントをお持ちでない方はこちら',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4739F0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 25.0,
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    //todo: 画面遷移
                    // Navigator.pushNamed(context, "/forget_password");
                  },
                  minWidth: 0,
                  height: 0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    'パスワードを忘れましたか？',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4739F0),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 300,
                margin: EdgeInsets.only(
                  top: 50,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await context.read<FirebaseAuthentication>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                      FirebaseAuth.instance.authStateChanges().listen(
                        (User? user) {
                          if (user != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Builder(builder: (context) {
                                  return CalendarPage();
                                }),
                              ),
                            );
                          } else {
                            print('sign in error');

                            /// メールアドレスまたはパスワードエラーdialog
                            // ShowDialog(
                            //   doubleButtonOrNot: false,
                            //   title: S().error,
                            //   content: S().errorDialogLogin,
                            //   buttonText: S().back,
                            //   onPressed: () {
                            //     Navigator.pop(context);
                            //   },
                            // ).alertShowDialog(context);
                          }
                        },
                      );
                    }
                  },
                  child: Text(
                    'ログイン',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
