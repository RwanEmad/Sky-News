import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant.dart';
import '../../controller/Api.dart';
import '../widget/CategoriesButton.dart';
class Categories extends StatefulWidget {
  late String Category;
  Categories(this.Category);
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: backGround,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding  (
                padding: const EdgeInsets.all(20.0),
                child: Text("${widget.Category} News",
                  style:TextStyle(
                    color: textColor,
                    fontSize:fontxlarg,
                  ),
                ),
              ),//*category screen title
              Container(
                height: MediaQuery.of(context).size.height/14,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoriesButton(colorsButton: Colors.purple,textButton: "${widget.Category}",),
                  ],

                ),
              ),
              Expanded (
                child:FutureBuilder( future: Api.fetchCategoryArtiles(widget.Category),  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return (snapshot.hasData)? ListView.builder(itemCount:snapshot.data.length ,itemBuilder: (BuildContext context, int index) {
                    return   GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse(snapshot.data[index].url))) throw 'Could not launch ${snapshot.data[index].url}';
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
                                  image: NetworkImage('${snapshot.data[index].urlToImage}'),
                                ),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25),),
                                color:Colors.cyan,
                              ),
                            ), //news image
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${snapshot.data[index].title}",textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: fontSubTitele,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ) ,  //*news title text
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: (){
                                      Share.share('${snapshot.data[index].url}', subject: 'thank you for sharing through SKY NEWA APP');
                                    },
                                    icon: Icon(Icons.share_rounded,size: 25,),
                                    hoverColor:Color.fromRGBO(0, 0, 0, 0.05),
                                  ),
                                ),//*share
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: (){
                                      FlutterClipboard.copy('${snapshot.data[index].url}').then(( value ){
                                        Scaffold.of(context).showSnackBar(new SnackBar(
                                          content: new Text("Copy Done!"), ));
                                      });
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

                      ),
                    );
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
