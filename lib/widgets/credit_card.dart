import 'package:flutter/material.dart';

///THIS WIDGET IS USED TO CREATE CREDIT CARD WIDGET FOR PAYMENT
class EaseCreditCard extends StatefulWidget {
  const EaseCreditCard(
      {Key? key,
      this.name = " name",
      this.number = "00000000000",
      this.cvv = "000",
      this.month = "12",
      this.year = "2021"})
      : super(key: key);

  final String cvv;
  final String month;
  final String name;
  final String number;
  final String year;

  @override
  _EaseCreditCardState createState() => _EaseCreditCardState();
}

class _EaseCreditCardState extends State<EaseCreditCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: 158,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 25,
                      ),
                      onTap: () {
                        // Action
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.number,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Month / Year",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.month} / ${widget.year}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Image.asset(
                    "widgets/credit card/card1.svg",
                    width: 50,
                    height: 50,
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
