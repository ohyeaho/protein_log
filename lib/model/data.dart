import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Data {
  Data(DocumentSnapshot doc) {
    this.name = doc['name'];
    this.intake = doc['intake'];
  }

  String? name;
  int? intake;
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<DocumentSnapshot> documentList = [];
  List<DocumentSnapshot> proteinList = [];

  String test = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text('ドキュメント一覧取得'),
            onPressed: () async {
              // コレクション内のドキュメント一覧を取得
              final snapshot = await FirebaseFirestore.instance.collection('users').doc('YxmRVGeofDB4vpAyS8ea').collection('data').get();
              // 取得したドキュメント一覧をUIに反映
              setState(() {
                documentList = snapshot.docs;
              });
            },
          ),
          // コレクション内のドキュメント一覧を表示
          Column(
            children: documentList.map((doc) {
              Timestamp timestamp = doc['date'];
              DateTime date = timestamp.toDate();
              return ListTile(
                title: Text('total: ${doc['total']}'),
                subtitle: Text('date: $date'),
              );
            }).toList(),
          ),
          ElevatedButton(
            child: Text('ドキュメントを指定して取得'),
            onPressed: () async {
              // コレクションIDとドキュメントIDを指定して取得
              final document = await FirebaseFirestore.instance
                  .collection('users')
                  .doc('YxmRVGeofDB4vpAyS8ea')
                  .collection('data')
                  .doc('2HU2FNilhrmrWg6fN29b')
                  .collection('protein')
                  .doc('Nf5HvkNQT4Drq3gcTgfe')
                  .get();
              // 取得したドキュメントの情報をUIに反映
              setState(() {
                test = '${document['name']} ${document['intake']}';
              });
            },
          ),
          // ドキュメントの情報を表示
          ListTile(title: Text(test)),
        ],
      ),
    );
  }
}
