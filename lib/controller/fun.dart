import 'dart:js';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class fun{
static void share(String Link) {
  Share.share('$Link',
      subject: 'thank you for sharing through SKY NEWA APP');
}
static void copy(String Link, var context) {
  FlutterClipboard.copy('$Link').then(( value ){
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("Copy Done!"), ));
     });
  }
static void openLink(String Link) async{
    if (!await launchUrl(Uri.parse(Link)))
      throw 'Could not launch ${Link}';
  }
}