import 'package:bites/Admin/Provider/vendorRequest_Provider.dart';
import 'package:bites/Admin/adminDrawer.dart';
import 'package:bites/Admin/viewLicense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class VendorRequests extends StatelessWidget {
  const VendorRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Vendor Requests",
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
        centerTitle: true,
      ),
      drawer: AdminPanel(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future:
                    Provider.of<VendorRequestProvider>(context, listen: false)
                        .getItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("An Error occured while fetching data"),
                    );
                  } 
                  else {
                    return Consumer<VendorRequestProvider>(
                      builder: (context, vendorProvider, child) {
                        final item = vendorProvider.items;

                        return Container(
                          height: item.length * 350,
                          width: 500,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: item.length,
                              itemBuilder: (context, index) {
                                final itemList = item.values.elementAt(index);
                                final id = item.keys;
                                final userId = id.elementAt(index);
                                print(userId);
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    height: 320,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                  child: Image.network(
                                                    itemList['img'],
                                                    fit: BoxFit.cover,
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
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name : ${itemList['ownerName']}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "LICENSE ID:  ",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    itemList['licenseId'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "PHONE NO:  ",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    itemList['phone'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "EMAIL:  ",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    itemList['email'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OpenPdf(
                                                              licenseUrl: itemList[
                                                                  'licenseProof'],
                                                              ownerName: itemList[
                                                                  'ownerName'],
                                                            )));
                                              },
                                              child: Text("View License",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  )),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                vendorProvider.Updating
                                                    ? CircularProgressIndicator(
                                                        strokeCap:
                                                            StrokeCap.round,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ).animate().fade(
                                                        duration:
                                                            const Duration(
                                                                seconds: 2))
                                                    : ElevatedButton(
                                                        style: ButtonStyle(
                                                            foregroundColor:
                                                                WidgetStatePropertyAll(Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background),
                                                            backgroundColor:
                                                                WidgetStatePropertyAll(Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .tertiary)),
                                                        onPressed: () {
                                                          vendorProvider
                                                              .acceptRequest(
                                                                  userId);
                                                        },
                                                        child: const Text(
                                                            "Approve")),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        foregroundColor:
                                                            WidgetStatePropertyAll(
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background),
                                                        backgroundColor:
                                                            WidgetStatePropertyAll(
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .tertiary)),
                                                    onPressed: () {
                                                      vendorProvider.deleteAccount(userId);
                                                    },
                                                    child:
                                                        const Text("Decline"))
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
                      },
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
