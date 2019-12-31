import 'package:flutter/material.dart';
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var _isAksaraMurdha = false;
  var _isUsingE = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: (){
                setState(() {
                 _isAksaraMurdha = !_isAksaraMurdha;                                
                });
  
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Gunakan Aksara murdha", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),),
                            Text("Lorem ipsum dolor sit amet consectuer.")
                          ],
                        )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Switch(
                            value: _isAksaraMurdha,
                            onChanged: (e){
                              print(e.toString());
                              setState(() {
                                _isAksaraMurdha = !_isAksaraMurdha;                                
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            Divider(),

            InkWell(
              onTap: (){
                print("e");
                setState(() {
                  _isUsingE = !_isUsingE;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Gunakan é untuk taling dan e untuk pepet", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),),
                            Text("Lorem ipsum dolor sit amet consectuer.")
                          ],
                        ),
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Switch(
                            value: _isUsingE,
                            onChanged: (e){
                              print(e.toString());
                              setState(() {
                                _isUsingE = !_isUsingE;                               
                              });
                            },
                          )
                        ],
                      )

                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
      
    );
  }
}