import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:wallcano/app_const.dart';
import 'package:wallcano/bloc/wallpaper_bloc.dart';
import '../ui_helper/app_colors.dart';
import '../ui_helper/app_widgets/custom_container.dart';
import 'image_view_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key,required this.catName,this.colorName});
  final String catName;
  final String?colorName;
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
    late ScrollController _scrollController;
    int page=1;
    @override
  void initState() {
    super.initState();
    widget.catName=='Best of the month'?context.read<WallpaperBloc>().add(ImageOfMonthEvent()): context.read<WallpaperBloc>().add(SearchImageEvent(searchQuery: widget.catName.toLowerCase().replaceAll(' ', '+'),color:widget.colorName?.toLowerCase(),pageCount: page));
   pageUpdate();
  }
 Future<void>pageUpdate() async {
   _scrollController=ScrollController()..addListener(() {
     if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
       setState(() {
         page+=1;
       });
       context.read<WallpaperBloc>().add(SearchImageEvent(searchQuery: widget.catName.toLowerCase().replaceAll(' ', '+'),color:widget.colorName?.toLowerCase(),pageCount: page));
     }
   });
 }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient:LinearGradient(
                    colors: [AppColors.background[0],AppColors.background[1]],
                    begin:Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
            child:Padding(
              padding:  EdgeInsets.all(11.0.sp),
              child:   getImages(),
            )
        ),
      ),
    );
  }
  Widget getImages(){
      return BlocBuilder<WallpaperBloc,WallpaperState>(
          builder: (context,state){
            if(state is WallpaperLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if (state is WallpaperLoadedState){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// category name & color palette
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.catName,style: TextStyle(fontSize: 35.sp,fontWeight: FontWeight.w500,color: Colors.black),),
                      SizedBox(width:5.sp),
                      Expanded(
                        child:colorPalette() ,
                      )
                    ],
                  ),
                  ///total image found
                  Text('${state.images.totalResults} wallpaper available',style: TextStyle(fontSize: 20.sp,color: Colors.grey.shade900,fontWeight: FontWeight.w300)),
                  SizedBox(height:state.images.totalResults!=0?5.sp:MediaQuery.of(context).size.height*0.2,),
                  ///loading images from api
                  state.images.totalResults!=0?getCategoryWallpaper(state):Center(child: Lottie.asset('assets/lottie/notFound.json'),),
                ],
              );
            }
            else if(state is WallpaperErrorState){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage,style: const TextStyle(fontWeight: FontWeight.w500,fontSize:18),),
                  SizedBox(height: 10.sp),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                       borderRadius: BorderRadius.circular(15),
                        child: Lottie.asset('assets/lottie/internetError.json',fit: BoxFit.fitWidth)
                    ),
                  ),
                ],
              );
            }
            return Container();
          }
          );
    }
    Widget colorPalette(){
      return Container(
        height: 45.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:Colors.blue.withOpacity(0.3),
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppConst.listOfColors.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(6),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CategoryPage(catName: widget.catName,colorName:AppConst.listOfColors[index]['colorName'],)));
                  },
                  child: Container(
                    height:35,
                    width: 40,
                    decoration: BoxDecoration(
                        color: AppConst.listOfColors[index]['colorValue'],
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
              );
            }),
      );
    }
    Widget getCategoryWallpaper(WallpaperLoadedState state){
      return Expanded(
        child: MasonryGridView.builder(
          controller:_scrollController ,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          itemCount: state.images.photos!.length,
          itemBuilder: (context,index){
            return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewPage(url: state.images.photos![index].src!.portrait!, photographerInfo:state.images.photos![index].photographerUrl! ,)));
                },
                child: AppContainerForApiImg(height:(index+1)%2!=0?300:250, width: MediaQuery.of(context).size.width, img: state.images.photos![index].src!.portrait!, radius: 25));
          },
        ),
      );
    }
}
