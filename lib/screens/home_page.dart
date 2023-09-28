import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallcano/app_const.dart';
import 'package:wallcano/bloc/wallpaper_bloc.dart';
import 'package:wallcano/screens/image_view_page.dart';
import '../ui_helper/app_colors.dart';
import '../ui_helper/app_widgets/custom_container.dart';
import 'category_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController=TextEditingController();
@override
  void initState() {
    super.initState();
    context.read<WallpaperBloc>().add(ImageOfMonthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [AppColors.background[0], AppColors.background[1]],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0.sp),
            child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Search field
                  Container(
                    height: 50.sp,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color:Colors.transparent,
                    ),
                    child:TextFormField(
                        controller: _searchController,
                        onFieldSubmitted: (value) async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage(catName:_searchController.text)));
                          _searchController.clear();
                        },
                        decoration: InputDecoration(
                           fillColor: AppColors.searchBarColor,
                            filled: true,
                            hintText: 'Find Wallpaper_',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400, fontSize: 16.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5.sp, color: Colors.blue.shade200),
                                borderRadius: BorderRadius.circular(15.sp)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.searchBarColor,
                                ),
                                borderRadius: BorderRadius.circular(15.sp)),
                            suffixIcon: InkWell(
                              onTap: () async {
                                if(_searchController.text!=''){
                                await Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage(catName:_searchController.text)));
                                _searchController.clear();
                                }
                              },
                              child: Icon(
                                Icons.search_sharp,
                                size: 25.sp,
                                color: Colors.grey.shade400,
                              ),
                            )),
                      ),
                  ), SizedBox(
                    height: 25.sp,
                  ),
                  ///Best of month
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        "Best of the month",
                        style:
                            TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryPage(catName:"Best of the month")));
                        },
                        child: Text('See more...',style:
                        TextStyle(fontSize: 16.sp,color: Colors.grey.shade400,fontWeight: FontWeight.w700)
                        ),
                      )
                    ],
                  ),
                   SizedBox(
                    height: 10.sp,
                  ),
                   SizedBox(
                    height: 250.sp,
                    width: double.infinity,
                    child:getImageOfMonth()
                  ),
                   SizedBox(height: 25.sp,),
                  ///category part
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      Text(
                        "Category",
                        style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 10.sp,
                  ),
                  getCategory()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCategory(){
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
           childAspectRatio: 8/4
        ),
        itemCount: AppConst.listOfCategory.length,
        itemBuilder: (context,index){
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage(catName:AppConst.listOfCategory[index]['categoryName'])));
              },
              child: AppContainerForOfflineImg(height:40.sp, width: MediaQuery.of(context).size.width, radius:10.sp,img: AppConst.listOfCategory[index]['img'],catTitle:AppConst.listOfCategory[index]['categoryName'],));
        }
    );
  }

  Widget getImageOfMonth() {
    return BlocBuilder<WallpaperBloc,WallpaperState>(
        builder: (context,state) {
          if (state is WallpaperLoadingState) {
            return const Center(child: CircularProgressIndicator(),);
          }
          else if (state is WallpaperLoadedState) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) =>
                            ImageViewPage(url: state.images.photos![index].src!
                                .portrait!, photographerInfo:state.images.photos![index].photographerUrl!,)));
                      },
                      child: AppContainerForApiImg(
                          height: 300.sp,
                          width: 180.sp,
                          img: state.images.photos![index].src!.portrait!,
                          radius: 25),
                    ),
                  );
                });
          }
          else if (state is WallpaperErrorState) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,width: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: const Center(child: Icon(Icons.signal_wifi_connected_no_internet_4)
                        ),
                      )
                  );
                }
            );
          }
          return Container();
        }
    );
  }

}
