import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Slides extends StatelessWidget {
  Slides({super.key});
  final List<String> imgList = [
    'https://thebakermama.com/wp-content/uploads/2017/02/Pizza-Toast-square.jpeg',
        'https://www.modernhoney.com/wp-content/uploads/2022/05/Double-Double-Cheeseburger-with-Fries-Recipe-scaled.jpg',
    'https://www.simplyrecipes.com/thmb/KE6iMblr3R2Db6oE8HdyVsFSj2A=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__09__easy-pepperoni-pizza-lead-3-1024x682-583b275444104ef189d693a64df625da.jpg',
    'https://tiffycooks.com/wp-content/uploads/2021/09/Screen-Shot-2021-09-21-at-5.21.37-PM.png',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 1000.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        viewportFraction: 0.6,
        aspectRatio: 2.0,
      ),
      items: imgList
          .map((item) => GestureDetector(
                onTap: () {
                  print(item);
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: 1000,
                              height: 900,
                            ),
                          ),
                        ),
                      ),
                   
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
