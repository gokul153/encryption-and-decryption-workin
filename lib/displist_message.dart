import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ui/AddhintWidget.dart';
import 'package:ui/db/model/funtions/db_functions.dart';
import 'package:ui/message_encrpt.dart';
import 'package:ui/messagestore.dart';

class messagestoreddisp extends StatelessWidget {
  const messagestoreddisp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllmessages();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          waddmessage(),
          const Expanded(child: listveiw()),
          IconButton(onPressed: (){
            Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => txtencrypt()));
          }, icon:Icon(Icons.arrow_back_outlined))
        ],
      )),
    );
  }
}
