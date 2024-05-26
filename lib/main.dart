import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: D3(),
    );
  }
}

class D3 extends StatefulWidget {
  const D3({super.key});

  @override
  State<D3> createState() => _D3State();
}

class _D3State extends State<D3> {
  ScrollController? _con;
  double _rx = 0.0;
  double _ry = 0.0;
  double _rz = 0.0;
  @override
  void initState() {
    _con = ScrollController();
    _con!.addListener(() {
      setState(() {
        //_ry = (_con!.offset / (MediaQuery.of(context).size.width));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 28, 44),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _con,
              itemCount: listofimages.length,
              itemBuilder: (c, i) {
                return Transform(
                  alignment: rotateycalc(
                          i: i,
                          con: _con!,
                          w: MediaQuery.of(context).size.width)
                      .$2,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, .002)
                    ..rotateX(0)
                    ..rotateY(rotateycalc(
                            i: i,
                            con: _con!,
                            w: MediaQuery.of(context).size.width)
                        .$1)
                    ..rotateZ(0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.zero,
                    // elevation: 10,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 7, 28, 44),
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage(listofimages[i])),
                    ),

                    // child: SizedBox(
                    //   //       height: 150,
                    //   width: MediaQuery.of(context).size.width,
                    //    ,
                    // ),
                  ),
                );
              })),
    );
  }
}

List<String> listofimages = [
  "assets/IMG-20240525-WA0015.jpg",
  "assets/IMG-20240525-WA0016.jpg",
  "assets/IMG-20240525-WA0017.jpg",
  "assets/IMG-20240525-WA0019.jpg",
  "assets/IMG-20240525-WA0022.jpg"
];

(double, Alignment) rotateycalc({required ScrollController con, w, i}) {
  //return ;
  Alignment? align;

  double y = con.offset / w;
  double? rotatey;
  if (y.floor() - 1 < 0) {
    if (i == 0) {
      rotatey = y;
      align = FractionalOffset.centerRight;
    } else {
      align = FractionalOffset.centerLeft;
      rotatey = -(1 - y);
    }
  } else {
    if (i == y.floor()) {
      align = FractionalOffset.centerRight;
      rotatey = ((y - (y.toInt())));

      print(" first $rotatey   y=  $y  align = $align");
    } else {
      align = FractionalOffset.centerLeft;
      rotatey = -(1 - (y - (y.toInt())));
      print(" second $rotatey   y=  $y  align = $align");
    }
  }
  return (rotatey, align);
}
