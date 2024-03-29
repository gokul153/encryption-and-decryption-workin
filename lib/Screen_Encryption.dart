import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui/home.dart';

class EncryptionPage extends StatefulWidget {
  const EncryptionPage({Key? key}) : super(key: key);

  @override
  State<EncryptionPage> createState() => _EncryptionPageState();
}

class _EncryptionPageState extends State<EncryptionPage> {
  String? _path;
  String? pat;
  String? encFilepath;
  String? filename;
  String status = "Waiting For action to be performed";

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getExternalStorageDirectory();
    final newFile = File('${appStorage!.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  bool _validate = false;
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<File> saveFile(String file) async {
    Directory? appStorage = await getExternalStorageDirectory();
    var fileName = (file.split('/').last);
    final newfile = ('${appStorage!.path}/$fileName');

    return File(file).copy(newfile);
  }

  Future<File> saveFile1(String file) async {
    const appStorage = ('/storage/emulated/0/Download');
    var fileName = (file.split('/').last);
    final newfile = ('$appStorage/$fileName');

    return (File(file).copy(newfile));
  }

  final _textController = TextEditingController();

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('ENCRYPTION',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 25,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              )),
        ],
      ),
    );
  }

  Widget _buildAddFileButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () async {
              PlatformFile? _platformFile;
              final file = await FilePicker.platform.pickFiles();

              if (file != null) {
                _platformFile = file.files.first;

                pat = _platformFile.name;
                _path = _platformFile.path;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Color.fromARGB(255, 30, 189, 242),
                    content: Text(
                      ' File Selected\n File path:$_path',
                      textAlign: TextAlign.center,
                    )));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color.fromARGB(255, 30, 189, 253),
                    content: Text(
                      ' File not Selected.Abort',
                      textAlign: TextAlign.center,
                    )));
                print("abort");
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 49, 30, 253),
              shape: const StadiumBorder(),
            ),
            child: Text(
              "Add File",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEncryptButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 49, 30, 253),
              shape: const StadiumBorder(),
            ),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              setState(() {
                status = "Encrypting...........";
                _textController.text.isEmpty
                    ? _validate = true
                    : _validate = false;
              });
              if (_path != null && _textController.text != null) {
                print(_path);

                // Creates an instance of AesCrypt class.
                AesCrypt crypt = AesCrypt();

                // Sets encryption password.
                // Optionally you can specify the password when creating an instance
                // of AesCrypt class like:
                crypt.aesSetMode(AesMode.cbc);
                crypt.setPassword(_textController.text);

                // Sets overwrite mode.
                // It's optional. By default the mode is 'AesCryptOwMode.warn'.
                crypt.setOverwriteMode(AesCryptOwMode.rename);

                try {
                  // Encrypts  file and save encrypted file to a file with
                  // '.aes' extension added. In this case it will be '$_path.aes'.
                  // It returns a path to encrypted file.

                  encFilepath = crypt.encryptFileSync(_path!);

                  print('The encryption has been completed successfully.');
                  setState(() {
                    status = "Encryption completed...............";
                  });
                  print('Encrypted file: $encFilepath');

                  final newFile = await saveFile(encFilepath!);
                  //final newfile1 = await saveFile1(encFilepath!);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color.fromRGBO(255, 49, 30, 253),
                      content: Text(
                        ' File Encryption Success',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color.fromARGB(255, 3, 34, 174),
                      content: Text(
                        ' File Saved',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                  print(newFile);
                  // print(newfile1);
                } on AesCryptException catch (e) {
                  // It goes here if overwrite mode set as 'AesCryptFnMode.warn'
                  // and encrypted file already exists.
                  if (e.type == AesCryptExceptionType.destFileExists) {
                    print('The encryption has been completed unsuccessfully.');
                    print(e.message);
                  }
                }
              }
              if (_path == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color.fromARGB(255, 49, 30, 253),
                    content: Text(
                      'Please select file',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )));
              }
              setState(() {
                _textController.clear();
              });
            },
            child: Text(
              "Encrypt",
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  letterSpacing: 1.5,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: TextField(
        controller: _textController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          fillColor: Color.fromARGB(0, 196, 196, 196),
          // fillColor: Colors.,
          filled: true,
          errorText: _validate ? 'please enter password' : null,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 49, 30, 253), width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 30, 189, 253), width: 1.5)),
          hintText: "Enter password",
        ),
        obscureText: true,
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.width * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 10,
                  blurRadius: 100,
                  offset: Offset(20, 20), // changes position of shadow
                ),
              ],
              color: Color(0xff282828),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildPasswordRow(),
                _buildAddFileButton(),
                _buildEncryptButton()
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //return SafeArea(
    //child:
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.53,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 30, 189, 253),
                  borderRadius: BorderRadius.only(
                      // bottomLeft: Radius.circular(70),
                      // bottomRight: Radius.circular(70),
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ///Text(status),
                     // Text("loading Wait"),
                     IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return Home_screen();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.home_max_outlined)) 
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildContainer(),
              ],
            )
          ],
        ),
      ),
      // ),
    );
  }
}
