import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/movie_model.dart';

class CustomImageSlider extends StatefulWidget {

  final Movie movie;
  const CustomImageSlider({super.key, required this.movie});

  @override
  _CustomImageSliderState createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  List<Image> images = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      for (var url in widget.movie.images) {
        images.add(Image.network(url, fit: BoxFit.cover));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
      ),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: image
            );
          },
        );
      }).toList(),
    );
  }
}