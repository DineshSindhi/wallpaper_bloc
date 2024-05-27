import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_bloc/presentation/bloc/search_bloc.dart';
import 'package:wallpaper_bloc/presentation/bloc/search_event.dart';
import 'package:wallpaper_bloc/presentation/bloc/search_state.dart';

import '../data/model/photo_model.dart';
import 'detail_page.dart';

class SearchData extends StatefulWidget {
  String value;
  String mColor;

  SearchData({required this.value, this.mColor = ''});

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  ScrollController? scrollerController;
  int totalWallpaper = 0;
  int totalPage = 1;
  int pageCount = 1;
  List<PhotoModel>allWallpaper = [];

  @override
  void initState() {
    super.initState();
    scrollerController = ScrollController();
    scrollerController!.addListener(() {
      if (scrollerController!.position.pixels ==
          scrollerController!.position.maxScrollExtent) {
        print('End List');
        totalPage = totalWallpaper ~/ 16 + 1;
        if (totalPage > pageCount) {
          pageCount++;
          context.read<SearchBloc>().add(SearchWallpaper(
              query: widget.value, Color: widget.mColor, page: pageCount));
          setState(() {

          });
        } else {
          print('Page Not Add');
        }
      }
    });
    context.read<SearchBloc>().add(
        SearchWallpaper(query: widget.value, Color: widget.mColor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wallpaper'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,),
      body: BlocListener<SearchBloc, SearchState>(
          listener: (_, state) {
            if (state is SLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
              Text(pageCount !=1 ? "Next Page Loading":'Loading')));
            } else if (state is SErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.msg}")));
            } else if (state is SLoadedState) {
              totalWallpaper = state.mData.total_results!;
              allWallpaper.addAll(state.mData.photos!);
              setState(() {

              });
            }
          },
        child: ListView(
          controller: scrollerController,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${widget.value} ',style: TextStyle(fontSize: 32),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('${totalWallpaper} wallpaper available',style: TextStyle(fontSize: 20),),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: allWallpaper.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9/15
              ), itemBuilder: (context, index) {

              var mData=allWallpaper[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsWall(img: mData,mIndex: index,),));
                },
                child: Hero(
                  tag: '$index',
                  child: Container(
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network('${mData.src!.portrait}',fit: BoxFit.fill,)),
                  ),
                ),
              );
            },),
          ],
        ),
      ),
    );
  }
}