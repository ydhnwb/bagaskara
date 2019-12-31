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
                      Text("Built by @ydhnwb", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                      Text("Dibuat menggunakan flutter dan firebase ml-vision. Lihat projek secara utuh di github [https://github.com/ydhnwb/bagaskara]."),
                    ],
                  )
                ),
              ),
            ),
            
            

            Card(
              child: InkWell(
                onTap: (){},
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Thanks to @bennylin", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                      Text("Terima kasih untuk @bennylin yang sudah membuat transliterasi jawa dan mengconvert library aksara jawa ke dart / flutter plugin."),
                    ],
                  )
                ),
              ),
            ),

          ],
        ),
      ),
      
    );
  }

  _launchURL(String s) async {
    String url = s;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}