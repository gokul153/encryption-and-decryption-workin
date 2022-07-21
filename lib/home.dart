import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ui/Screen_Decryption.dart';
import 'package:ui/Screen_Encryption.dart';
import 'package:ui/message_encrpt.dart';
import "package:file_cryptor/file_cryptor.dart";
import 'package:encrypt/encrypt.dart' as enc;

//simport 'package:packageandnavigation/message_encrpt.dart'
class Home_screen extends StatefulWidget {
  Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  bool loading = false;
  bool _isgranted = false;
  String keyvalues = "12345678910112587413698741236987";
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  requestStoragePermission() async {
    if (!await Permission.storage.isGranted) {
      PermissionStatus result = await Permission.storage.request();
      if (result.isGranted) {
        setState(() {
          _isgranted = true;
        });
      } else {
        _isgranted = false;
      }
    }
  }

  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    final filename = result.files.first.name;
    print(result.files.first.size);
    print(result.files.first.path);
    final path = result.files.first.path;
    final filen = result.files.first;

    //_openFile(file);
    //_Encryptfile(path, filen);
  }

  // void _openFile(PlatformFile file) {
  //  OpenFile.open(file.path);
  //   print("opening file");
  //  _Encryptfile();
  // }

  // void _Encryptfile(filepath, filename) async {
  //   print("file encrption stated");
  //   print(keyvalues.length);
  //   try {
  //     if (keyvalues.length != 32) {
  //       print("key invalid");
  //     }
  //     FileCryptor fileCryptor = FileCryptor(
  //       key: keyvalues,
  //       iv: 16,
  //       dir: filepath,
  //     );
  //     io.File encryptedFile = await fileCryptor.encrypt(
  //         inputFile: filename, outputFile: "file.aes");
  //     print(encryptedFile.absolute);
  //   } catch (e) {
  //     print("file not registerd");
  //   }

  //   // io.File decryptedFile = await fileCryptor.decrypt(
  //   //      inputFile: "file.aes", outputFile: "file.txt");
  //   // print(decryptedFile.absolute);
  // }

  @override
  Widget build(BuildContext context) {
    requestStoragePermission();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(60),
              child: const Text(
                "KRYPT IT!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25, fontFamily: 'Bold', color: Colors.white),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 30, 189, 253),
          ),
          // body: Body_shape(),
          body: SafeArea(
            child: Container(
              // width: double.maxFinite,
              //height: double.minPositive,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // MainAxisAlignment:   MainAxisAlignment.center,
                  const Text(
                    "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 30, 189, 253),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Container(
                        //       alignment: Alignment.center,
                        //       child: const Text(
                        //         "Select this icon to attach file",
                        //         textAlign: TextAlign.justify,
                        //       ),
                        //     ),
                        //   ),
                        //Icon(
                        // Icons.file_open_outlined,
                        //  size: 36.0,
                        //   //  print("get file");
                        // ),
                        // IconButton(
                        //   onPressed: () {
                        //     print("select file");
                        //     print("Downloading Requested");
                        //     _pickFile();
                        //     //   Download_to();
                        //   },
                        //   icon: Icon(
                        //     Icons.file_open_rounded,
                        //     size: 36.0,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        //r     Padding(
                        //  padding: const EdgeInsets.all(8.0),
                        // child: ElevatedButton(
                        //   onPressed: () {
                        //    print("Udergo Compression and encryption");
                        //   },
                        //  child: Text('Compress & Enrypt'),
                        //),
                        // ),
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                print("Encrypt only");
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (ctx) {
                                    return EncryptionPage();
                                  }),
                                );
                              },
                              child: Text('Encrypt File'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          print("Decryption is intiated");
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) {
                              return decryptionPage();
                            }),
                          );
                        },
                        child: Text("Decrypt file ")),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // print("Text Encryption is started");
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) {
                            return txtencrypt();
                          }),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 255, 255, 255)),
                      ),
                      child: Text(
                        "Message Encryption",
                        style: TextStyle(
                          color: Color.fromARGB(255, 30, 189, 253),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

//class EncryptData {
class MyEncrypt {
  static final mykey = enc.Key.fromUtf8('brotherhood');
  static final myIv = enc.IV.fromUtf8('gokuldas');
  static final MyEncrypter = enc.Encrypter(enc.AES(mykey));
}
