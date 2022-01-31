import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/profile/wallet/transactions/TransactionsDao.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;
import 'transactions/Transaction.dart' as my;



class WalletPage extends StatefulWidget {
  WalletPage({Key? key,  required this.toggleBackground}) : super(key: key);
  final ToggleCallback toggleBackground;

  final transactionDao = TransactionDao();

  @override
  State<StatefulWidget> createState() => _WalletPageState(toggleBackground: toggleBackground);
}

class _WalletPageState extends State<WalletPage> {
  _WalletPageState ({Key? key, required this.toggleBackground});
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
                loadHalfLogo(),
                const SizedBox(width: 50.0),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 150,
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
                  Text("Wallet",
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
                  Text("Recent Transactions:                                       ",
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(53, 53, 53, 1.0)
                      )
                  ),
                  const SizedBox(height: 25),
                  _getTransactionsList(),
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget _getTransactionsList() {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    return Expanded(
      child: FirebaseAnimatedList(
        query: widget.transactionDao.getOwnTransactionsQuery(uid!),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final task = my.Transaction.fromJson(json);
          return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 6, right: 6),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0,
                              color: Colors.black
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 6, right: 12, top: 12),
                      height: 60,
                      child: Wrap(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(task.title,
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                            color: const Color.fromRGBO(53, 53, 53, 1.0)
                                        )
                                    ),
                                    Text(task.date,
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            color: const Color.fromRGBO(53, 53, 53, 1.0)
                                        )
                                    ),
                                  ],
                                ),
                                Text(task.value.toString() + " A",
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
                ],
          );
        },
      ),
    );
  }

  Future<int> _getTokens() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    final query = FirebaseDatabase.instance.ref().child("users").orderByKey().equalTo(uid);
    DataSnapshot snapshot = await query.get();
    return snapshot.child(uid!).child("tokens").value as int;
  }


  Container loadHalfLogo() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Image.asset(constants.HALF_LOGO, scale: 2)
    );
  }
}
typedef ToggleCallback = dynamic Function(dynamic);