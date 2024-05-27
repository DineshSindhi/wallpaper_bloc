import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';

import '../data/model/photo_model.dart';

class DetailsWall extends StatefulWidget {
  PhotoModel img;
  int mIndex;
  DetailsWall({required this.mIndex,required this.img});

  @override
  State<DetailsWall> createState() => _DetailsWallState();
}

class _DetailsWallState extends State<DetailsWall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wallpaper'),backgroundColor: Colors.blueGrey,centerTitle: true,),
      body: Stack(
        children: [
          Hero(
            tag: '${widget.mIndex}',
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              //image: '${mData.src!.portrait}'

              child: Image.network('${widget.img.src!.portrait}',fit:BoxFit.cover,),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    mBox(widget:Icon(Icons.info,size: 35,color: Colors.white,),
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context) =>
                              Container(
                                color: Colors.blueGrey,
                                height: 100,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Photographer - ${widget.img.photographer}',style: TextStyle(fontSize: 20,color: Colors.white),),
                                    FaIcon(FontAwesomeIcons.heart,
                                      color: widget.img.liked==true?Colors.red: Colors.white,
                                      size: 30,)
                                  ],
                                ),
                              ),);
                        }
                    ),
                    mText('Info'),

                  ],
                ),
                Column(
                  children: [

                    mBox(widget:Icon(Icons.download,size: 35,color: Colors.white,),
                        onTap: (){
                          saveWall(context);
                        }
                    ),
                    mText('Save'),
                  ],
                ),
                Column(
                  children: [
                    mBox(widget:Icon(Icons.brush,size: 35,color: Colors.white,),
                        onTap: (){
                          //applyHomeWall(context);
                          showModalBottomSheet(context: context, builder: (context) =>
                              Container(
                                color: Colors.blueGrey,
                                height: 200,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                         await applyHomeWall(context);
                                          Navigator.pop(context);


                                        },
                                        child: Text('Home Screen',style: TextStyle(fontSize: 22,color: Colors.white),)),
                                    InkWell(
                                        onTap: (){
                                          applyLockWall(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Lock Screen',style: TextStyle(fontSize: 22,color: Colors.white),)),
                                    InkWell(
                                        onTap: (){
                                          applyBothWall(context);
                                          Navigator.pop(context);
                                        },

                                        child: Text('Both Screen',style: TextStyle(fontSize: 22,color: Colors.white),)),
                                  ],
                                ),
                              ),);
                        }
                    ),
                    mText('Apply'),

                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  mBox({required Widget widget, VoidCallback? onTap})=> InkWell(
    onTap:onTap,
    child: Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.blueGrey.shade500,
      ),
      width: 70,
      height: 70,
      child:widget,

    ),
  );

  mText(String text)=> Text(text,style: TextStyle(fontSize: 20,color: Colors.white),);

  saveWall(BuildContext context){
    GallerySaver.saveImage('${widget.img.src!.portrait}').then((value)
    { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wallpaper Save!!")));});
  }

  applyHomeWall(BuildContext context,){
    Wallpaper.imageDownloadProgress('${widget.img.src!.portrait}').listen((event) {

    },onDone: ()  {
      Wallpaper.homeScreen(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          options: RequestSizeOptions.RESIZE_FIT
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Apply Wallpaper HomeScreen Successful!!")));
      });

    },onError: (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error:$e")));
    });
  }

  applyLockWall(BuildContext context,){
    Wallpaper.imageDownloadProgress('${widget.img.src!.portrait}').listen((event) {

    },onDone: (){
      Wallpaper.lockScreen(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          options: RequestSizeOptions.RESIZE_FIT
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Apply Wallpaper LockScreen Successful!!")));
      });

    },onError: (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error:$e")));
    });
  }

  applyBothWall(BuildContext context,){
    Wallpaper.imageDownloadProgress('${widget.img.src!.portrait}').listen((event) {
    },onDone: (){
      Wallpaper.bothScreen(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          options: RequestSizeOptions.RESIZE_FIT
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Apply Wallpaper BothScreen Successful!!")));
      });

    },onError: (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error:$e")));
    });
  }
}
