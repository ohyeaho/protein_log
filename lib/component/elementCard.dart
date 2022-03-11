import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ElementCard extends StatefulWidget {
  ElementCard(
      {required this.color,
      required this.name,
      required this.controller,
      required this.total});
  final Color color;
  final String name;
  TextEditingController controller = TextEditingController();
  final int total;

  @override
  _ElementCardState createState() => _ElementCardState();
}

class _ElementCardState extends State<ElementCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: widget.color.withOpacity(0.4),
                child: Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Center(child: Text(widget.name)),
                ),
              ),
            ),

            ///今後基本値ボタンを付ける予定のため現在はコメントアウト
            // Expanded(child: Center(child: Text('肉'))),
            // Expanded(child: Center(child: Text('20g'))),
            Expanded(
                child: Center(
                    child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    textAlign: TextAlign.center,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(counterText: ''),
                    onChanged: (text) {
                      if (text.length > 0) {
                        // 入力値があるなら、それを反映する。
                        // print(await widget.total);
                        widget.total;
                        // setState(() {
                        //   // widget.total;
                        //   // total = int.parse(meetController.text) +
                        //   //     int.parse(fishController.text) +
                        //   //     int.parse(beansController.text) +
                        //   //     int.parse(milkController.text) +
                        //   //     int.parse(eggController.text) +
                        //   //     int.parse(otherController.text);
                        // });
                      } else {
                        this.widget.controller =
                            TextEditingController(text: '0');
                        // setState(() {
                        //   // this.widget.controller =
                        //   //     TextEditingController(text: '0');
                        // });
                      }
                      setState(() {});
                    },
                  ),
                ),
                Text('g'),
              ],
            ))),
          ],
        ),
      ),
    );
  }
}
