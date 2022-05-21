import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant.dart';
import '../../controller/fun.dart';
import '../../controller/Api.dart';
import '../widget/CategoriesButton.dart';
import 'package:share_plus/share_plus.dart';
import 'package:clipboard/clipboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGround,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
                    Padding  (
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Choose News Category",
                       style:TextStyle(
                         color: textColor,
                         fontSize:fontxlarg,
          ),
      ),
                    ),//*screen title
                    Container(
                      height: MediaQuery.of(context).size.height/14,
                      child: ListView(
                     scrollDirection: Axis.horizontal,
                        children: [
                          CategoriesButton(colorsButton: yellow,textButton: "sports",),
                          CategoriesButton(colorsButton: blue,textButton: "technology",),
                          CategoriesButton(colorsButton:orangeLight,textButton: "science",),
                          CategoriesButton(colorsButton: red,textButton: "health",),
                          CategoriesButton(colorsButton:green,textButton: "general",),
                          CategoriesButton(colorsButton: red,textButton: "entertainment",),
                          CategoriesButton(colorsButton: Colors.pinkAccent,textButton: "business",),

                        ],

                      ),//*categories bar
                    ),
                    Expanded (
                        child:FutureBuilder( future: Api.fetchArtiles(),  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          return (snapshot.hasData)? ListView.builder(itemCount:snapshot.data.length ,itemBuilder: (BuildContext context, int index) {
                            return   GestureDetector(
                              onTap: () async {
                                fun.openLink('${snapshot.data[index].url}');
                              },
                              child: Card(
                                elevation: 5,
                                color:white,
                                shadowColor: textColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image:DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(('${snapshot.data[index].urlToImage}'=='null')?
                                          "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.thewindowsclub.com%2Fwp-content%2Fuploads%2F2018%2F04%2FThis-Snap-in-Performed-A-Non-Valid-Operation-And-Has-Been-Unloaded.png&imgrefurl=https%3A%2F%2Fwww.thewindowsclub.com%2Fthis-snap-in-performed-a-non-valid-operation&tbnid=wc0DVJeUZIgwhM&vet=10CAcQMyiyAmoXChMIqPm73p7v9wIVAAAAAB0AAAAAEAQ..i&docid=Ja-18036C1zX-M&w=563&h=311&q=unloaded%20image&ved=0CAcQMyiyAmoXChMIqPm73p7v9wIVAAAAAB0AAAAAEAQ":'${snapshot.data[index].urlToImage}'),
                                        ),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25),),
                                        color:Colors.cyan,
                                      ),
                                    ), //*image
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${snapshot.data[index].title}",textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: fontSubTitele,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ) ,  //*text
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconButton(
                                            onPressed: (){
                                            fun.share('{snapshot.data[index].url}');
                                            },
                                            icon: Icon(Icons.share_rounded,size: 25,),
                                            hoverColor:Color.fromRGBO(0, 0, 0, 0.05),
                                          ),
                                        ),//*share
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconButton(
                                            onPressed: (){
                                              fun.copy('${snapshot.data[index].url}',context);
                                              },
                                            icon: Icon(Icons.copy_rounded ,size:25 ,),
                                            hoverColor:Color.fromRGBO(0, 0, 0, 0.05),
                                          ),
                                        ),//*copy
                                        Padding(
                                          padding: const EdgeInsets.only(left: 180.0),
                                          child: Text("${snapshot.data[index].publishedAt}",textAlign: TextAlign.right,),
                                        ),//*open link
                                      ],
                                    ),

                                  ],
                                ),

                              ),//*news card
                            );//*scroll vertical
                           },
                          ) : Center(child: CircularProgressIndicator());
                         },
                        ),
                      ),
                    ],
          ),
        ),
      ),
    );
  }
}
