import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallcano/screens/photographer_info_page.dart';
import 'package:wallpaper/wallpaper.dart';

class ImageViewPage extends StatefulWidget {
   ImageViewPage({super.key,required this.url, required this.photographerInfo});
  final String url;
  final String photographerInfo;
  late double mWidth,mHeight;
  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  bool isDownloaded=false;
  bool colorToggle1=false;
  bool colorToggle2=false;
  bool colorToggle3=false;
  @override
  Widget build(BuildContext context) {
    widget.mHeight=MediaQuery.of(context).size.height;
    widget.mWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image:DecorationImage(image: NetworkImage(widget.url),fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>PhotographerInfoPage(photographerInfoUrl:widget.photographerInfo)));
                          setState(() {
                            colorToggle1=true;
                            colorToggle2=false;
                            colorToggle3=false;
                          });
                          },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(colorToggle1?Colors.blue.withOpacity(0.4):Colors.grey.withOpacity(0.4)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ))
                        ),
                          child:const Icon(Icons.info_outline_rounded),
                      ),
                    ),
                    const Text('Info',style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.white),)
                  ],
                ),
              ),
              const SizedBox(width: 30,),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                         await downloadWallpaper();
                         setState(() {
                           isDownloaded=true;
                           colorToggle2=true;
                           colorToggle1=false;
                           colorToggle3=false;
                         });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(colorToggle2?Colors.blue.withOpacity(0.4):Colors.grey.withOpacity(0.4)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ))
                        ),
                        child: Icon(isDownloaded?Icons.download_done:Icons.download),
                      ),
                    ),
                    const Text('Download',style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.white),)
                  ],
                ),
              ),
              const SizedBox(width: 30,),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                        setWallpaper();
                        setState(() {
                          colorToggle3=true;
                          colorToggle2=false;
                          colorToggle1=false;
                        });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(colorToggle3?Colors.blue.withOpacity(0.4):Colors.grey.withOpacity(0.4)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ))
                        ),
                        child:const Icon(Icons.brush_outlined),
                      ),
                    ),
                    const Text('Set as',style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.white),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Future<void> downloadWallpaper() async{
    GallerySaver.saveImage(widget.url).then((value) {
      print(value);
    });
  }
  void setWallpaper(){
   var streamProgress= Wallpaper.imageDownloadProgress(widget.url);
   streamProgress.listen((event) {
    print(event) ;
   },
   onDone: (){
     Wallpaper.homeScreen(
       width: widget.mWidth,
       height: widget.mHeight,
       options: RequestSizeOptions.RESIZE_EXACT
     );
   },
     onError: (eventError){
     print(eventError);
     }
   );
  }
}
