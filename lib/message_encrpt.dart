import 'dart:convert';
import 'dart:ui';

import 'package:clipboard/clipboard.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ui/displist_message.dart';
import 'package:ui/home.dart';

String gencrypt = "";
int chance = 0;

class txtencrypt extends StatefulWidget {
  txtencrypt({Key? key}) : super(key: key);

  @override
  State<txtencrypt> createState() => _txtencryptState();
}

class _txtencryptState extends State<txtencrypt> {
  @override
  final _textcontrol = TextEditingController();
  final _keycontrol = TextEditingController();
  String data = "intial data";
  int key = 2;
  int value = 0;
  int i = 0;
  String encryptedtext = "";
  String decryptedtext = "";
  var ciphervalue, dvalue;
  void encrypt_message(int key1) async {
    //final key = encrypt.Key.;
    //final iv = encrypt.IV.fromSecureRandom(16);
    //final Encrypter = encrypt.Encrypter(encrypt.AES(key));
    //final encrypted = Encrypter.encrypt(data, iv: iv);
    //final decrypted = Encrypter.decrypt(encrypted, iv: iv);
    //print(decrypted);
    //print(encrypted.bytes);
    //print(encrypted.base16);
    //print(encrypted.base64);
    //encryptedtext = encrypted.bytes.toString();
    //print(data);
    encryptedtext = "";
    for (i = 0; i < data.length; i++) {
      int value = data.codeUnitAt(i);
      print("orginal value ");
      print(value);
      ciphervalue = value + key;
      if (ciphervalue > 122) {
        value = value - 26 + key;
      } else {
        value = value + key;
      }
      encryptedtext += String.fromCharCode(value);
      //  String oneAsString = 1.toString();
      //print(value);
      print("encrypted text");
      print(encryptedtext);
    }
  }

  void decrypt_mesage(int key1, String encrypttext) async {
    //decryptedtext = "";
    //chance++;
   // print("chance is");
    //print(chance);
    encryptedtext = encrypttext;
    for (i = 0; i < encryptedtext.length; i++) {
      int dvalue = encryptedtext.codeUnitAt(i);
      ciphervalue = dvalue - key;
      print("dvalue");
      print(dvalue);
      if (ciphervalue < 97) {
        dvalue = dvalue + 26 - key;
      } else {
        dvalue = dvalue - key;
      }
      print("$dvalue after decryption");
      decryptedtext += String.fromCharCode(dvalue);
    }
    print("decryption completed");
    print(decryptedtext);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Message or Text Encryption"),
      //  backgroundColor: Color(255, 49, 30, 253),
        backgroundColor: Color.fromARGB(255, 49, 30, 253),
       ),
        body: SafeArea(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: _textcontrol,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 49, 30, 253), width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 30, 189, 253), width: 1.5)),
                  hintText:
                      'Enter the message to be encrypted/decrypted in alphabets ',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    
                    "Enter the Key  ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 30, 189, 253)
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              TextField(
                controller: _keycontrol,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 49, 30, 253), width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 30, 189, 253), width: 1.5)),
                  hintText: 'Enter the key to encrypt',
                ),
              ),
              Padding(
                
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 49, 30, 253),
              shape: const StadiumBorder(),
            ),
                        onPressed: () {
                          data = _textcontrol.text;
                          // var keyc = (int.parse(_keycontrol.text));
                       //   if(chance>100)
                      //    {

                       //   }
                          try {
                            setState(() {
                              var keyc = (int.parse(_keycontrol.text));
                              String checkket = _keycontrol.text;
                              // print(data);
                              encryptedtext = " ";
                              print("entered key is");
                              print(keyc);
                              // key = int.parse(keyc);
                              //print(key);
                              // if (keyc != null) {
                              key = keyc;
                              // ignore: unnecessary_null_comparison
                              if (checkket == "") {
                                print("enter vallid key");
                                key = 2;
                                print("default key is used");
                                encrypt_message(key);
                                gencrypt = encryptedtext;
                              } else {
                                if (checkket.length <= 2) {
                                  print("enter valid key1");
                                  const snackBar = SnackBar(
                                    content: Text('Enter valid key >100'),
                                  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.R
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  encrypt_message(key);
                                  setState(() {
                                    gencrypt = encryptedtext;
                                  });
                                }
                              }
                            });
                          } catch (exception) {
                            print("enter proper keyy");
                            print("enter a key greater than 100");
                            const snackBar = SnackBar(
                              content: Text('Enter valid key in numbers'),
                            );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.R
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        icon: Icon(Icons.enhanced_encryption_rounded,
                        color: Color.fromARGB(255, 182, 190, 193),),
                        label: Text(
                          "Encrypt",
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton.icon(
                            
                            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 49, 30, 253),
              shape: const StadiumBorder(),
            ),
                          onPressed: () {
                             chance++;
                              print("chance is");
                              print(chance);
                             decryptedtext = "";
                            if(chance>100)
                            {
                              Navigator.pop(context, 'Chance Exeeded go back');
                            }
                            //data = _textcontrol.text;
                            // var keyc = (int.parse(_keycontrol.text));
                            //   data = _keycontrol.text;
                            try {
                              setState(() {
                                data = _textcontrol.text;
                                var keyc = (int.parse(_keycontrol.text));
                                key = keyc;
                                if (keyc < 100) {
                                  print("enter a key greater than 100");
                                  const snackBar = SnackBar(
                                    content: Text('Enter valid key >100'),
                                  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.R
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                String encrptmessage = _textcontrol.text;
                                decrypt_mesage(keyc, encrptmessage);
                              });
                            } catch (exeption) {
                              print("enter proper key");
                              print("enter a key greater than 100");
                              const snackBar = SnackBar(
                                content: Text('Enter valid key in numbers'),
                              );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.R
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          icon: Icon(Icons.enhanced_encryption_rounded),
                          label: Text("Decrypt"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    
                    "Encrypted message",
                    style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 30, 189, 253))
                    ,
                    
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Container(
                      
                      width: 300.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        
                        // borderRadius: BorderRadius.circular(24.0),
                        border: Border.symmetric(),
                        color: Color.fromARGB(255, 49, 30, 253),
                      ),
                      child: SizedBox(
                        child: Text(
                          encryptedtext,
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 20,
                            color: Colors.white,
                            height: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(encryptedtext);
                      },
                      icon: Icon(Icons.copy_all_outlined))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Decrypted message",
                    style: TextStyle(fontSize: 20,
                    color: Color.fromARGB(255, 30, 189, 253),
                    ),
                  ),
                ],
              ),
              // SizedBox.fromSize(size: 10),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Container(
                      width: 300.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(24.0),
                        border: Border.symmetric(),
                        color:  Color.fromARGB(255, 49, 30, 253),
                      ),
                      child: SizedBox(
                        child: Text(
                          decryptedtext,
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 20,
                            color: Colors.white,
                            height: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(decryptedtext);
                      },
                      icon: Icon(Icons.copy_all_outlined))
                ],
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                       style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 49, 30, 253),
              shape: const StadiumBorder(),
            ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return messagestoreddisp();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Veiw stored/Add',
                      ),
                    ),
                     IconButton(onPressed: (){
            Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => Home_screen()));
          }, icon:Icon(Icons.arrow_back_outlined))
                  ],
                ),
              ),
             
            ],
          ),
        )));
  }
}
