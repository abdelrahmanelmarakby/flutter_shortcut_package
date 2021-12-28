import 'package:ease/ease.dart';
import 'package:flutter/material.dart';

//THIS WIDGET IS USED TO DISPLAY THE DETAILS OF A PRODUCT  :: IT SHOWS ONLY THE PRODUCT  IMAGE AND ON CLICK OF THE IMAGE IT DISPLAYS THE DETAILS OF THE PRODUCT
class ProductCard extends StatefulWidget {
  const ProductCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.primarytActionLabel,
      required this.price,
      required this.rate,
      this.onSubAction,
      this.onPrimaryAction,
      this.icon = Icons.favorite_border,
      this.closedHeight = 150,
      this.openedHeight = 300})
      : super(key: key);

  final double closedHeight;
  final IconData icon;
  final ImageProvider<Object> image;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSubAction;
  final double openedHeight;
  final String price;
  final String primarytActionLabel;
  final int rate;
  final String title;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  late Animation _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 375), vsync: this);
    _animation = Tween(begin: widget.closedHeight, end: widget.openedHeight)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeOut));

    _controller.addListener(() {
      setState(() {});
    });
  }

  Icon starIcon(Color color) {
    return Icon(
      Icons.star,
      size: 10.0,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            isOpened = !isOpened;
            if (isOpened) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          });
        },
        child: Container(
          height: _animation.value,
          // width: 150.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(.2),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: const Offset(0.0, -5.0),
              ),
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.0),
          ),

          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                height: 130.0,
                width: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: widget.image,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: AnimatedOpacity(
                  opacity: _animation.value == widget.openedHeight ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Txt(
                          widget.title,
                          weight: FontWeight.w600,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      widget.price,
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                      children: List.generate(
                                          widget.rate,
                                          (index) =>
                                              starIcon(Colors.yellow.shade700)),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Material(
                                    color: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: InkWell(
                                      onTap: widget.onSubAction,
                                      child: Center(
                                        child: Icon(
                                          widget.icon,
                                          size: 15.0,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 0.0),
                          width: 130.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade400,
                                offset: const Offset(0.0, 10.0),
                                spreadRadius: -5.0,
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: widget.onPrimaryAction,
                              child: Center(
                                child: Text(
                                  widget.primarytActionLabel,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
