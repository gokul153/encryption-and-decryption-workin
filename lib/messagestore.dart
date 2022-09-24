import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ui/db/model/data_model.dart';
import 'package:ui/db/model/funtions/db_functions.dart';

class listveiw extends StatelessWidget {
  const listveiw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: messagelistnotifier,
      builder: (BuildContext ctx, List<messagemodel> student, Widget? child) {
        return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = student[index];
              return ListTile(
                title: Text(data.hint),
                subtitle: Text(data.message),
                trailing: IconButton(
                  onPressed: () {
                    if (data.id != null) {
                      print("delection is intiated");
                      deletemessage(data.id!);
                    } else {
                      print("message id is null");
                      //deletemessage()
                    }
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
                leading: IconButton(
                  onPressed: () {
                    /* if (data.id != 0) {
                      deletemessage(data.id!);
                    } else {
                      print("student id is null");
                    }*/
                    FlutterClipboard.copy(data.message);
                    //FlutterClipboard.copy(encryptedtext);
                  },
                  icon: Icon(Icons.copy),
                  color: Colors.blue,
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: student.length);
      },
    );
  }
}
