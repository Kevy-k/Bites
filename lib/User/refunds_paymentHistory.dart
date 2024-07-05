import 'package:bites/User/paymentHistory.dart';
import 'package:bites/User/refunds.dart';
import 'package:flutter/material.dart';

class RefundAndPaymentPage extends StatefulWidget {
  const RefundAndPaymentPage({super.key});

  @override
  State<RefundAndPaymentPage> createState() => _RefundAndPaymentPageState();
}

class _RefundAndPaymentPageState extends State<RefundAndPaymentPage> {
   final pages =const [PaymentHistory(),RefundPage()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:pages[_currentIndex],
           bottomNavigationBar: Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15, top: 8),
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.tertiary,
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
                icon: Icon(Icons.history),
                label: "Payment History",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.credit_card_rounded), label: "Refunds"),
            
            ],
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            selectedItemColor: Theme.of(context).colorScheme.background,
            unselectedItemColor: Theme.of(context).colorScheme.background,
            selectedIconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.primary),
                showUnselectedLabels: true,
            unselectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.background,
            ),
            unselectedLabelStyle:
                TextStyle(color: Colors.white),
            enableFeedback: true,
          ),
        ),
      ),
    ),
    );
  }
}
