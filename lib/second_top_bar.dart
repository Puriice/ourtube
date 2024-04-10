import 'package:flutter/material.dart';

class SecondTopBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 45,
            width: double.infinity,
            child: Container(
              color: bgColor,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListView.builder(
                  itemCount: titles.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    if (index == 0) {
                      return Container(
                        width: sizes[index],
                        height: 35,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:
                              Icon(Icons.explore_rounded, color: Colors.black),
                        ),
                      );
                    }
                    return Container(
                      width: sizes[index],
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          titles[index],
                          style: TextStyle(color: Colors.black),
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
    );
  }
}
