import 'package:bagaskara_redefined/bloc/aksara/aksara_bloc.dart';
import 'package:bagaskara_redefined/bloc/aksara/aksara_event.dart';
import 'package:bagaskara_redefined/bloc/aksara/aksara_state.dart';
import 'package:bagaskara_redefined/pages/about_page.dart';
import 'package:bagaskara_redefined/pages/setting_page.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<String> choices = ['Pengaturan', 'Tentang'];
  AksaraBloc _aksaraBloc;
  var _latinToAksara = true;
  var _domainTextController = TextEditingController();
  String _targetText = "";

  @override
  void initState() {
    super.initState();
    _aksaraBloc = BlocProvider.of<AksaraBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Bagaskara"),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: _onSelectedPopup,
              itemBuilder: (context) {
                return choices
                    .map((String choice) => PopupMenuItem(
                          value: choice,
                          child: Text(choice),
                        ))
                    .toList();
              })
        ],
      ),
      body: BlocListener<AksaraBloc, AksaraState>(listener: (context, state) {
        if (state is AksaraInitState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AksaraLoadingState) {
          print("is load");
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AksaraLoadedState) {
          if (state.isFromFile) {
            _domainTextController.text = state.domainText;
          }
          _targetText = state.targetText;
        }
      }, child: BlocBuilder<AksaraBloc, AksaraState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  PreferredSize(
                    preferredSize: Size(_size.width, 56),
                    child: Material(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 56,
                                width: _size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (_latinToAksara) ? "Latin" : "Aksara",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                icon: Icon(Icons.compare_arrows),
                                color: Colors.grey[700],
                                onPressed: () {
                                  setState(() {
                                    _latinToAksara = !_latinToAksara;
                                  });

                                  if (state is AksaraLoadedState) {
                                    _domainTextController.text = _targetText;
                                    if (_latinToAksara) {
                                      _aksaraBloc.add(LatinToAksara(
                                          s: _domainTextController.text
                                              .toString()
                                              .trim()));
                                    } else {
                                      _aksaraBloc.add(AksaraToLatin(
                                          s: _domainTextController.text
                                              .toString()
                                              .trim()));
                                    }
                                  }
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 56.0,
                                width: _size.width,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  (_latinToAksara) ? "Aksara" : "Latin",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 4,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 0, bottom: 20, left: 20, right: 20),
                      decoration: BoxDecoration(color: Colors.white),
                      width: _size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: Row(
                              children: <Widget>[
                                Spacer(),
                                if (_domainTextController.text
                                    .toString()
                                    .trim()
                                    .isNotEmpty)
                                  IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      _domainTextController.text = "";
                                      setState(() {
                                        _targetText = "";
                                      });
                                    },
                                  )
                              ],
                            ),
                          ),
                          TextField(
                            controller: _domainTextController,
                            maxLines: null,
                            style: TextStyle(fontSize: 24),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: (_latinToAksara)
                                    ? "Tulis sesuatu dalam latin"
                                    : "Tulis sesuatu dalam aksara jawa"),
                            onChanged: (String s) {
                              if (_latinToAksara) {
                                _aksaraBloc.add(LatinToAksara(s: s));
                              } else {
                                _aksaraBloc.add(AksaraToLatin(s: s));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    width: _size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              _targetText,
                              style: TextStyle(
                                  fontSize: 24, fontFamily: "NotoSansJavanese"),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              if (state is AksaraLoadedState)
                                _showCopyButton(_targetText.isNotEmpty, context)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Informasi'),
                content: const Text(
                    'Scan teks via camera hanya bisa mendeteksi tulisan latin. Mode akan diubah ke Latin -> Aksara'),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('BATAL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                      child: const Text('MENGERTI'),
                      onPressed: () {
                        setState(() {
                          _latinToAksara = true;
                        });
                        Navigator.pop(context);
                        _aksaraBloc.add(ScanFromCamera());
                      }
                  )
                ]
              );
            },
          );
        },
        child: Icon(Icons.camera),
      ),
    );
  }

  _showCopyButton(bool state, BuildContext ctx) {
    if (state) {
      return IconButton(
        icon: Icon(
          Icons.content_copy,
          color: Colors.grey,
        ),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: _targetText));
          Scaffold.of(ctx).showSnackBar(SnackBar(
            content: Text("Berhasil  disalin"),
          ));
        },
      );
    }
    return Container();
  }

  void _onSelectedPopup(String s) {
    if (s == choices[0]) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AboutPage()));
    }
  }
}
