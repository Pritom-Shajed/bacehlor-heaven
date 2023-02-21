import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/home%20screen/home_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: HeaderWidget(),
          ),
          Column(
            children: [
              CarouselSlider.builder(
                itemCount: items.length,
                itemBuilder: (context, index, int pageViewIndex) =>
                    items[index],
                options: CarouselOptions(
                  height: 150.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              verticalSpace,
              searchBar(controller: searchTextController),
            ],
          ),
          Expanded(
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: gridItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemBuilder: (_, index) {
                  return gridItems[index];
                }),
          ),
        ],
      ),
    );
  }
}
