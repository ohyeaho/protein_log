import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:protein_log/model/cloud_firestore_manage.dart';
import 'package:protein_log/model/firebase_auth.dart';
import 'package:protein_log/pages/calendar_page.dart';
import 'package:protein_log/pages/sign_in_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('サインアップ'),
      ),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// 名前
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '氏名',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        width: 140,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: lastNameController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: MultiValidator([
                            RequiredValidator(errorText: '*性は必須です'),
                            PatternValidator(r'^[^\s]*$', errorText: '空文字は使えません'),
                            MaxLengthValidator(15, errorText: '15文以内です'),
                          ]),
                          decoration: InputDecoration(
                            labelText: '性',
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
                          left: 10,
                        ),
                        width: 140,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: firstNameController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: MultiValidator([
                            RequiredValidator(errorText: '*名は必須です'),
                            PatternValidator(r'^[^\s]*$', errorText: '空文字は使えません'),
                            MaxLengthValidator(15, errorText: '15文以内です'),
                          ]),
                          decoration: InputDecoration(
                            labelText: '名',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFFD1D1D1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      /// メールアドレステキスト
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'メールアドレス',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
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

                      /// パスワードテキスト
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'パスワード',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          obscureText: true,
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
                    ],
                  ),

                  /// 既にアカウント持ち
                  SizedBox(height: 30),
                  Container(
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                        );
                      },
                      minWidth: 0,
                      height: 0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        'すでにアカウントをお持ちの方はこちら',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF4739F0),
                        ),
                      ),
                    ),
                  ),

                  /// 利用規約
                  SizedBox(height: 30),
                  Container(
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        // todo: プライバシーポリシー
                        // Navigator.pushNamed(context, "/signup_policy");
                      },
                      minWidth: 0,
                      height: 0,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '利用規約・プライバシーポリシー',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  /// 登録ボタン
                  SizedBox(height: 30),
                  Container(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          dynamic result = await context.read<FirebaseAuthentication>().signUp(
                                name: lastNameController.text.trim() + ' ' + firstNameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                          if (result == true) {
                            FirebaseAuth.instance.authStateChanges().listen((User? user) {
                              if (user != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CalendarPage(),
                                  ),
                                );
                                CloudFirestoreManage().setUserAccount(
                                  name: lastNameController.text.trim() + ' ' + firstNameController.text.trim(),
                                );
                              }
                            });
                          } else if (result == 'error:exist') {
                            print('error');

                            /// 既存メールアドレスエラーdialog
                            // ShowDialog(
                            //   doubleButtonOrNot: false,
                            //   title: S().error,
                            //   content: S().emailExistDialog,
                            //   buttonText: S().back,
                            //   onPressed: () {
                            //     Navigator.pop(context);
                            //   },
                            // ).alertShowDialog(context);
                          }
                        }
                      },
                      child: Text(
                        '利用規約に同意の上、登録する',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
