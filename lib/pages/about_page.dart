import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Built by Prieyudha Akadita S",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                            "Built using Flutter and Firebase ML-Vision. This is an open-source app that you can see the code on my github"),
                        RaisedButton(
                          onPressed: () =>
                              _launchURL("https://github.com/ydhnwb/bagaskara"),
                          child: Text("See on github"),
                        )
                      ],
                    )),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Thanks to Fanni Naditya Putra",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                            "Big thanks to Fanni Naditya Putra for make this app available on Play Store"),
                        RaisedButton(
                          onPressed: () =>
                              _launchURL("https://instagram.com/fanninputra"),
                          child: Text("Visit his profile"),
                        )
                      ],
                    )),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Thanks to Benny Lin",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                            "Thanks to Benny Lin who created a library aksara jawa for dart"),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
