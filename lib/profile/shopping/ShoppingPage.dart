import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unihub/profile/shopping/BuyConfirmationPage.dart';
import 'package:unihub/profile/wallet/transactions/TransactionsDao.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;



class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key? key,  required this.toggleBackground}) : super(key: key);
  final ToggleCallback toggleBackground;

  final transactionDao = TransactionDao();

  @override
  State<StatefulWidget> createState() => _ShoppingPageState(toggleBackground: toggleBackground);
}

class _ShoppingPageState extends State<ShoppingPage> {
  _ShoppingPageState ({Key? key, required this.toggleBackground});
  final ToggleCallback toggleBackground;
  var halfLogoUtils = HalfLogoUtils();
  var tokens = "Loading...";

  @override
  void initState() {
    super.initState();
    _getTokens().then((value){
      setState(() {
        tokens = value.toString();
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constants.MAIN_BLUE,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, size: 50, color: Colors.white,), onPressed: () {
                  toggleBackground(false);
                  Navigator.pop(context);
                }),
                halfLogoUtils.loadHalfLogo(Alignment.center),
                const SizedBox(width: 50.0),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 240,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromRGBO(170, 170, 170, 1.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 25,
                  ),
                  Text("Shopping",
                      style: GoogleFonts.roboto(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(53, 53, 53, 1.0)
                      )
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Balance:',
                        style: GoogleFonts.roboto(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(53, 53, 53, 1.0)
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: " " + tokens + " Achandos",
                              style: GoogleFonts.roboto(
                                  fontSize: 21,
                                  fontWeight: FontWeight.normal,
                                  color: const Color.fromRGBO(53, 53, 53, 1.0)
                              )
                          ),
                        ]
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildContainer("College Tuition", 50, context),
                  _buildContainer("Mental health clinic discount", 20, context),
                  _buildContainer("Cafeteria IST", 5, context),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        )
    );
  }

  InkWell _buildContainer(String desc, int price, BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => BuyConfirmationPage(desc: desc, price: price.toString(), changeTokens: changeTokens,)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 6, right: 6),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                  width: 1.0,
                  color: Colors.black
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 6, right: 12, top: 20),
          height: 60,
          child: Wrap(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(desc,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: const Color.fromRGBO(53, 53, 53, 1.0)
                        )
                    ),
                    Text(price.toString() + " A",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: const Color.fromRGBO(53, 53, 53, 1.0)
                        )
                    ),
                  ]
              )
            ],
          )
      ),
    );
  }

  int changeTokens(int price){
    int t = int.parse(tokens) - price;
    setState(() {
      tokens = t.toString();
    });
    return t;
  }

  Future<int> _getTokens() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    final query = FirebaseDatabase.instance.ref().child("users").orderByKey().equalTo(uid);
    DataSnapshot snapshot = await query.get();
    return snapshot.child(uid!).child("tokens").value as int;
  }


}
typedef ToggleCallback = dynamic Function(dynamic);