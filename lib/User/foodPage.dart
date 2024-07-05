import 'package:bites/Admin/Provider/addSpecial_Provider.dart';
import 'package:bites/User/Provider/showRestautants_provider.dart';
import 'package:bites/User/Provider/userInstance.dart';
import 'package:bites/User/view_restaurants.dart';
import 'package:bites/User/slides.dart';
import 'package:bites/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainFoodPage extends StatefulWidget {
  MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  final searchController = TextEditingController();
  Color mytheme = const Color.fromARGB(255, 191, 82, 43);

  final List<String> imgList = [
    'https://www.modernhoney.com/wp-content/uploads/2022/05/Double-Double-Cheeseburger-with-Fries-Recipe-scaled.jpg',
    'https://www.simplyrecipes.com/thmb/KE6iMblr3R2Db6oE8HdyVsFSj2A=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__09__easy-pepperoni-pizza-lead-3-1024x682-583b275444104ef189d693a64df625da.jpg',
    'https://tiffycooks.com/wp-content/uploads/2021/09/Screen-Shot-2021-09-21-at-5.21.37-PM.png',
    'https://www.modernhoney.com/wp-content/uploads/2022/05/Double-Double-Cheeseburger-with-Fries-Recipe-scaled.jpg',
    'https://www.simplyrecipes.com/thmb/KE6iMblr3R2Db6oE8HdyVsFSj2A=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__09__easy-pepperoni-pizza-lead-3-1024x682-583b275444104ef189d693a64df625da.jpg',
    'https://tiffycooks.com/wp-content/uploads/2021/09/Screen-Shot-2021-09-21-at-5.21.37-PM.png',
    'https://www.modernhoney.com/wp-content/uploads/2022/05/Double-Double-Cheeseburger-with-Fries-Recipe-scaled.jpg',
    'https://www.simplyrecipes.com/thmb/KE6iMblr3R2Db6oE8HdyVsFSj2A=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__09__easy-pepperoni-pizza-lead-3-1024x682-583b275444104ef189d693a64df625da.jpg',
    'https://www.modernhoney.com/wp-content/uploads/2022/05/Double-Double-Cheeseburger-with-Fries-Recipe-scaled.jpg',
    'https://www.simplyrecipes.com/thmb/KE6iMblr3R2Db6oE8HdyVsFSj2A=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2019__09__easy-pepperoni-pizza-lead-3-1024x682-583b275444104ef189d693a64df625da.jpg',
    'https://tiffycooks.com/wp-content/uploads/2021/09/Screen-Shot-2021-09-21-at-5.21.37-PM.png',
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProfile>(context, listen: false);
    provider.getUsername();
  }

  @override
  Widget build(BuildContext context) {
    print("build1");
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Our Specials",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                child: Slides(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Consumer<UserProfile>(
                    builder: (context, value, child) {
                      print("Consumer");
                      return Text(
                        "${value.userFirstName.toUpperCase()} whats on your mind?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: mytheme,
              indent: 100,
            ),
            StreamBuilder(stream: Provider.of<SpecialsProvider>(context,listen: false).getSpecials(),
             builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              else if(snapshot.hasError){
                  return const Center(child: Text("Error"));
              }
              else{
                Map<String,Map<String,dynamic>> items=snapshot.data??{};
                return Container(
              height: 350,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    var itemid=items.keys.elementAt(index);
                    Map<String,dynamic> item=items[itemid]!;
                    return GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Image.network(
                                      item['ItemImg'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(item['ItemName']),
                                const SizedBox(
                                  width: 50,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            );
              }
             }),
            
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text(
                    "Restaurants near you",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Divider(
              color: mytheme,
              indent: 100,
            ),
            Consumer<ShowRestautantsProvider>(builder: (context, value, child) {
              return FutureBuilder<Map<String, Map<String, dynamic>>>(
                  future: value.restaurantsNearMe(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  Center(
                        child: ShimmerLoading(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("An error occurred while fetching data"),
                      );
                    } else if (snapshot.hasData) {
                      final restaurants = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant =
                              restaurants.values.elementAt(index);
                          final id=restaurants.keys;
                          return Container(
                            height: 200,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.network(
                                          restaurant['Img'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 200,
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant['Name'] ?? 'Unknown',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 12,
                                        ),
                                        Text(
                                          restaurant['Rating'] ?? 0.0,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          "   20-30 mins",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(restaurant['Catagory'] ??
                                            'Unknown'),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(restaurant['City'] ?? 'Unknown'),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(mytheme),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewRestaurant(rID: id.elementAt(index),restaurant: restaurant,),
                                        ),
                                      ),
                                      child: const Text(
                                        "Explore",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No restaurants found"),
                      );
                    }
                  });
            })
          ],
        ),
      ),
    );
  }
}
