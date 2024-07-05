import 'package:bites/User/Provider/showRestautants_provider.dart';
import 'package:bites/User/Provider/userInstance.dart';
import 'package:bites/User/myOrders.dart';
import 'package:bites/User/restaurant_page.dart';
import 'package:bites/User/user_profile.dart';
import 'package:bites/User/foodPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color mytheme = const Color.fromARGB(255, 191, 82, 43);
  final pages = [MainFoodPage(), RestaurantPage(), const MyOrders()];
  int _currentIndex = 0;
  final changeCity=TextEditingController();
  @override
  void initState() {
    Provider.of<UserProfile>(context, listen: false).getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 20, 19, 20),
      backgroundColor: Theme.of(context).colorScheme.background,
      // backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: mytheme),
        actionsIconTheme: const IconThemeData(size: 40),
        toolbarHeight: 70,
        title: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                useRootNavigator: false,
                context: context,
                builder: ((context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       const SizedBox(height: 30,),
                        Text("Enter the city to show restaurants near you",style: TextStyle(fontSize: 15),),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller:  changeCity,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 31, 31, 31),
                              filled: true,
                              alignLabelWithHint: true,
                              label: Text(
                                "City",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 191, 82, 43)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                          ),
                        ),
                        Consumer<ShowRestautantsProvider>(builder: (context,value,child){
                          if(value.isloading){
                            return const CircularProgressIndicator();
                          }
                          else{
                            return    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                          foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary)
                        ),
                        onPressed: ()async{
                        await  Provider.of<ShowRestautantsProvider>(context,listen: false).addCity(context, changeCity.text.trim());
                        Navigator.of(context).pop();
                        }, child:const Text("Change"));
                          }
                        })
                    
                      ],
                    ),
                  );
                }));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    size: 15,
                  ),
                  Text(
                    "Location",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Consumer<UserProfile>(builder: (context, value, build) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        value.City,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserProfilePage())),
              icon: const Icon(
                Icons.account_circle,
              )),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15, top: 8),
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: mytheme,
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset.zero)
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              currentIndex: _currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant), label: ""),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_shipping_outlined,
                  ),
                  label: "",
                )
              ],
              backgroundColor: Colors.black,
              selectedIconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.primary),
              unselectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.secondary,
              ),
              unselectedLabelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary),
              enableFeedback: true,
            ),
          ),
        ),
      ),
    );
  }
}
