import 'package:bites/User/Provider/showRestautants_provider.dart';
import 'package:bites/User/view_restaurants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatelessWidget {
  RestaurantPage({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    // fillColor: const Color.fromARGB(255, 31, 31, 31),
                    fillColor: Theme.of(context).colorScheme.background,
                    filled: true,
                    prefixIcon: GestureDetector(
                      onLongPress: () {},
                      child: Icon(
                        Icons.mic,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    hintText: "Search restaurants",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    )),
                    onChanged: (value){
                      Provider.of<ShowRestautantsProvider>(context,listen: false).setQuery( value);
                    },
              ),
            ),
           StreamBuilder(stream: Provider.of<ShowRestautantsProvider>(context).showAllrestaurants(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return  const Center(child:  CircularProgressIndicator());
              }
              else if(snapshot.hasError){
                return const Center(child: Text("Error"),);
              }
              else{
                Map<String,Map<String,dynamic>> restaurants=snapshot.data??{};
                return Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    String restaurantId=restaurants.keys.elementAt(index);
                    Map<String,dynamic> restaurant=restaurants[restaurantId]!;
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  ViewRestaurant( rID: restaurantId,restaurant: restaurant,)));
                      },
                      child: Container(
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
                                  restaurant['Name'],
                                  style:const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                   const Icon(
                                      Icons.star_outline_rounded,
                                      color: Colors.greenAccent,
                                    ),
                                    Text(
                                    restaurant['Rating'],
                                      style:const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  const  Text(
                                      " 20-30 mins",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                     Text(restaurant['Catagory']),
                                     SizedBox(width: 10,),
                                     Text(restaurant['City']),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
              }
            }),
            
          ],
        ),
      ),
    );
  }
}




