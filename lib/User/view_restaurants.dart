import 'package:bites/User/Provider/menu_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class ViewRestaurant extends StatefulWidget {
  const ViewRestaurant(
      {super.key, required this.rID, required this.restaurant});
  final Map<String, dynamic> restaurant; //details of current restaurant
  final String rID; //id of current restaurant
  @override
  State<ViewRestaurant> createState() => _ViewRestaurantState();
}

class _ViewRestaurantState extends State<ViewRestaurant> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Image.network('${widget.restaurant['Img']}')),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_rounded,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                //Restaurant Details
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.tertiary,
                          blurRadius: 15,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${widget.restaurant['Name']}",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.circle_rounded,
                                size: 10,
                                color: Colors.green,
                              ),
                              Text(
                                "|",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                              const Icon(
                                Icons.circle_rounded,
                                size: 10,
                                color: Colors.red,
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  width: 50,
                                  height: 30,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${widget.restaurant['Rating']}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "30-35 mins | ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                              Text(
                                "${widget.restaurant['City']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "${widget.restaurant['Catagory']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                            ],
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.delivery_dining,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              Text(
                                " Free Delivery on your order",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //Restaurant Details

                //Menu
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(50, 50),
                      topRight: Radius.elliptical(50, 50),
                      bottomLeft: Radius.elliptical(50, 50),
                      bottomRight: Radius.elliptical(50, 50),
                    ),
                    // color: Color.fromARGB(255, 69, 69, 69),
                    color: Theme.of(context).colorScheme.background,
                    // border: Border(top: BorderSide(color: Theme.of(context).colorScheme.tertiary,width: 5)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.tertiary,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Menu",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              // fillColor: const Color.fromARGB(255, 31, 31, 31),
                              fillColor:
                                  Theme.of(context).colorScheme.background,
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
                              hintText: "Search cusines",
                              hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 18),
                        child: Row(
                          children: [
                            Text(
                              "Top Picks",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        indent: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: StreamBuilder(
                            stream: Provider.of<MenuAndCartProvider>(context,
                                    listen: false)
                                .getMenuItems(widget.rID),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text(
                                    "Failed to fetch menu details");
                              } else {
                                Map<String, Map<String, dynamic>> menus =
                                    snapshot.data ?? {};
                                return Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: menus.length,
                                      itemBuilder: (context, index) {
                                        String menuId =
                                            menus.keys.elementAt(index);
                                        Map<String, dynamic> menu =
                                            menus[menuId]!;
                                        return LongPressDraggable<
                                            Map<String, dynamic>>(
                                          data: menu,
                                          feedback: Opacity(
                                            opacity: 0.7,
                                            child: Material(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary,
                                                    borderRadius:
                                                       const BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                height: 150,
                                                width: 400,
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 12.0),
                                                          child: SizedBox(
                                                            height: 120,
                                                            width: 150,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                              child:
                                                                  Image.network(
                                                                menu[
                                                                    'ItemImage'],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 200,
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          menu['ItemName'],
                                                          style: TextStyle(
                                                              
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .background),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '₹${menu['Price'].toString()}',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .background,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          childWhenDragging: Container(
                                            height: 150,
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 120,
                                                        width: 150,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                          child: Image.network(
                                                            menu['ItemImage'],
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        menu['ItemName'],
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '₹${menu['Price'].toString()}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          onDragStarted: () {
                                             Provider.of<MenuAndCartProvider>(context,listen: false).startDragging();
                                          },
                                          onDraggableCanceled: (_, __) {
                                            Provider.of<MenuAndCartProvider>(context,listen: false).stopDragging();
                                          },
                                          onDragEnd: (_) {
                                            Provider.of<MenuAndCartProvider>(context,listen: false).stopDragging();
                                          },
                                          child: Container(
                                            height: 150,
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 120,
                                                      width: 150,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        child: Image.network(
                                                          menu['ItemImage'],
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      menu['ItemName'],
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '₹${menu['Price'].toString()}',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 35,
                                                    )
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
                      ),
                    ],
                  ),
                ),
                // Menu
              ],
            ),
          ),
          // Drag Target (Cart)
        ],
      ),
      bottomNavigationBar: Consumer<MenuAndCartProvider>(builder: (context, value, child) {
        if(value.dragging){
          return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: DragTarget<Map<String, dynamic>>(
                    onAcceptWithDetails: (droppedItem) {
                      // Add the item to the cart
                      var item=droppedItem.data;
                      value.stopDragging();
                      value.addtoCart(item);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).colorScheme.background,
                          size: 20,
                        ),
                      );
                    },
                  ))
              .animate()
              .fadeIn(duration: Duration(seconds: 1))
              .slideY(begin: 1, end: 0.1, duration: Duration(milliseconds: 500))
              .shimmer(
                duration: Duration(seconds: 2),
                color: Theme.of(context).colorScheme.background,
              );
              
        }else{
          return Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.background,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Drop here",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            );
        }
      },),
      floatingActionButton: Container(
        height: 200,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  useRootNavigator: false,
                  context: context,
                  builder: ((context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(50, 50),
                            topRight: Radius.elliptical(50, 50)),
                        color: Theme.of(context).colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.tertiary,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Menu items ",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 20),
                          ),
                          Container(
                            height: 400,
                            child:
                            Consumer<MenuAndCartProvider>(builder: (context,value,child){
                              return StreamBuilder(stream: value.getMenuItems(widget.rID), 
                              builder:(context,snapshot){
                                if(snapshot.connectionState==ConnectionState.waiting){
                                  return const CircularProgressIndicator();
                                }
                                else if(snapshot.hasError){
                                  return const Text("Something went wrong");
                                }
                                else{
                                   Map<String, Map<String, dynamic>> menus =
                                    snapshot.data ?? {};
                                  return   ListView.builder(
                                itemCount: menus.length,
                                itemBuilder: (context, index) {
                                   String menuId =
                                            menus.keys.elementAt(index);
                                        Map<String, dynamic> menu =
                                            menus[menuId]!;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      title: Text(
                                        menu['ItemName'],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            fontSize: 18),
                                      ),
                                      trailing: Text(
                                       '₹${menu['Price'].toString()}',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            fontSize: 18),
                                      ),
                                    ),
                                  );
                                });
                                }
                              });
                             
                            }),
                            
                          ),
                        ],
                      ),
                    );
                  }));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.restaurant_menu_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Text(
                  "MENU",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
