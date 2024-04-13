import 'package:flutter/material.dart';

//provider
import 'package:provider/provider.dart';
import 'package:wetube/providers/current_type_index_provider.dart';

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
  SecondTopBarState createState() => SecondTopBarState();
}

class SecondTopBarState extends State<SecondTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      width: double.infinity,
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
                    return GestureDetector(onTap: () {
                      setState(() {
                        Provider.of<CurrentTypeIndexProvider>(context,
                                listen: false)
                            .current = index;
                      });
                    }, child: Consumer<CurrentTypeIndexProvider>(
                        builder: (context, currentIndexProvider, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: widget.sizes[index],
                        height: 35,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: currentIndexProvider.current == index
                              ? Colors.purple[100]
                              : widget.color,
                          borderRadius: BorderRadius.circular(10),
                          border: currentIndexProvider.current == index
                              ? Border.all(color: widget.color, width: 2)
                              : null,
                        ),
                        child: Center(
                          child: index == 0
                              ? Icon(
                                  Icons.explore_rounded,
                                  color: currentIndexProvider.current == index
                                      ? widget.color
                                      : Colors.black,
                                )
                              : Text(
                                  widget.titles[index],
                                  style: TextStyle(
                                    color: currentIndexProvider.current == index
                                        ? widget.color
                                        : Colors.black,
                                    fontWeight:
                                        currentIndexProvider.current == index
                                            ? FontWeight.bold
                                            : null,
                                  ),
                                ),
                        ),
                      );
                    }));
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
