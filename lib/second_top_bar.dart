import 'package:flutter/material.dart';

class SecondTopBar extends StatefulWidget {
  final List<String> titles;
  final List<double> sizes;
  final Color color;
  final dynamic bgColor;

  const SecondTopBar({
    Key? key,
    required this.titles,
    required this.sizes,
    required this.color,
    required this.bgColor,
  }) : super(key: key);

  @override
  _SecondTopBarState createState() => _SecondTopBarState();
}

class _SecondTopBarState extends State<SecondTopBar> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      width: double.infinity,
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 45,
              width: double.infinity,
              child: Container(
                color: widget.bgColor,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.titles.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: widget.sizes[index],
                          height: 35,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: current == index
                                ? Colors.purple[100]
                                : widget.color,
                            borderRadius: BorderRadius.circular(10),
                            border: current == index
                                ? Border.all(color: widget.color, width: 2)
                                : null,
                          ),
                          child: Center(
                            child: index == 0
                                ? Icon(
                                    Icons.explore_rounded,
                                    color: current == index
                                        ? widget.color
                                        : Colors.black,
                                  )
                                : Text(
                                    widget.titles[index],
                                    style: TextStyle(
                                      color: current == index
                                          ? widget.color
                                          : Colors.black,
                                      fontWeight: current == index
                                          ? FontWeight.bold
                                          : null,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
