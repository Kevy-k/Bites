import 'package:bites/User/Provider/menu_cart_provider.dart';
import 'package:bites/User/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: Provider.of<MenuAndCartProvider>(context, listen: false)
                    .getMyCart(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text("Error fetching cart");
                  } else if (snapshot.data!.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.7,
                        ),
                        Text("Your cart is empty"),
                        SizedBox(
                          height: 380,
                        ),
                      ],
                    );
                  } else {
                    Map<String, Map<String, dynamic>> cartItems =
                        snapshot.data ?? {};
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.25,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            var cartid = cartItems.keys.elementAt(index);
                            Map<String, dynamic> cart = cartItems[cartid]!;
                            return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                  onLongPress: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        useRootNavigator: false,
                                        context: context,
                                        builder: ((context) {
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Provider.of<MenuAndCartProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeItem(cartid);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const ListTile(
                                                    title: Text(
                                                      "Remove",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            bottomLeft: Radius.circular(25),
                                            topRight:
                                                Radius.elliptical(60, 60))),
                                    child: Row(
                                      children: [
                                        //cart item images
                                        Column(
                                          children: [
                                            Container(
                                              height: 150,
                                              width: 130,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromARGB(
                                                            255, 104, 103, 103),
                                                        spreadRadius: 1,
                                                        offset: Offset(1, 2),
                                                        blurRadius: 5)
                                                  ]),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(25)),
                                                child: Image.network(
                                                  cart['ItemImage'],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //cart item images
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  cart['ItemName'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "₹ ${cart['Price'].toString()} ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background),
                                                ),
                                                IconButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary),
                                                    ),
                                                    onPressed: () {
                                                      Provider.of<MenuAndCartProvider>(
                                                              context,
                                                              listen: false)
                                                          .decreaseItemQuantity(
                                                              cartid);
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  cart['Quantity'].toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                      fontSize: 18),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStatePropertyAll(
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .tertiary)),
                                                    onPressed: () {
                                                      Provider.of<MenuAndCartProvider>(
                                                              context,
                                                              listen: false)
                                                          .increaseItemQuantity(
                                                              cartid);
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          }),
                    );
                  }
                }),
            StreamBuilder(
                stream: Provider.of<MenuAndCartProvider>(context, listen: false)
                    .totalPrice(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text("Error Fetching cart items");
                  } else {
                    num totalPrice = snapshot.data ?? 0;
                    print(totalPrice);
                    return Container(
                      height: 98,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(50, 30),
                            topRight: Radius.elliptical(50, 30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer(
                            builder: (context, value, child) {
                              return Text(
                                "Total Price : ₹$totalPrice",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .background)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>  PaymentPage(total: totalPrice,)));
                              },
                              child: Text(
                                "Checkout",
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ))
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
