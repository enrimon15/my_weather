import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ItemTestList> listaOre = [
      new ItemTestList(ora: '02:00', gradi: '8 °C'),
      new ItemTestList(ora: '03:00', gradi: '10 °C'),
      new ItemTestList(ora: '04:00', gradi: '9 °C'),
      new ItemTestList(ora: '05:00', gradi: '9 °C'),
      new ItemTestList(ora: '06:00', gradi: '3 °C'),
      new ItemTestList(ora: '07:00', gradi: '-5 °C'),
      new ItemTestList(ora: '08:00', gradi: '3 °C'),
      new ItemTestList(ora: '09:00', gradi: '6 °C'),
      new ItemTestList(ora: '10:00', gradi: '7 °C'),
      new ItemTestList(ora: '11:00', gradi: '9 °C'),
      new ItemTestList(ora: '12:00', gradi: '23 °C'),
      new ItemTestList(ora: '13:00', gradi: '5 °C'),
      new ItemTestList(ora: '14:00', gradi: '6 °C'),
      new ItemTestList(ora: '15:00', gradi: '9 °C'),
      new ItemTestList(ora: '16:00', gradi: '2 °C'),
      new ItemTestList(ora: '17:00', gradi: '4 °C'),
      new ItemTestList(ora: '18:00', gradi: '21 °C'),
      new ItemTestList(ora: '19:00', gradi: '23 °C'),
      new ItemTestList(ora: '20:00', gradi: '4 °C'),
      new ItemTestList(ora: '21:00', gradi: '7 °C'),
      new ItemTestList(ora: '22:00', gradi: '8 °C'),
      new ItemTestList(ora: '23:00', gradi: '7 °C'),
      new ItemTestList(ora: '24:00', gradi: '9 °C'),
    ];

    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipPath(
          clipper: MyClipperCurved(),
          child: Container(
            padding: EdgeInsets.all(40),
            width: double.infinity,
            height: 430,
            color: Theme.of(context).primaryColor,
            /*decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Colors.white
                ]
              )
            ),*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'L\' Aquila,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      '18°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Text(
                  'Domenica 6',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 30,),
                Image.asset(
                  'assets/img/icons/cielocoperto.png',
                  height: 105,
                ),
                SizedBox(height: 30,),
                Text(
                  'Cielo Coperto',
                  style: TextStyle(
                    letterSpacing: 8,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 0,
            ),
            child: ListView.builder(
              //padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                if (listaOre[index].ora.substring(0,2) == '18') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(23),
                                  bottom: Radius.circular(23)
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 4,
                                    blurRadius:2,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            margin: EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Ora',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Image.asset(
                                  'assets/img/icons/cielocoperto.png',
                                  //alignment: Alignment.bottomLeft,
                                  height: 34,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        listaOre[index].ora.substring(0,2),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      Image.asset(
                        'assets/img/icons/cielocoperto.png',
                        //alignment: Alignment.bottomLeft,
                        height: 34,
                      ),
                      Text(
                        '${listaOre[index].gradi.split(' ')[0]}°',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: listaOre.length,
            ),
          ),
        ),
      ],
    );
  }
}

class MyClipperCurved extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path(); //define path
    /*path.lineTo(0, size.height-50);
    path.lineTo(size.width, size.height-200);
    path.lineTo(size.width, 0);*/
    path.lineTo(0, size.height-50);
    path.quadraticBezierTo(size.width/4, size.height-100, size.width/2, size.height-50);
    path.quadraticBezierTo(size.width-(size.width/4), size.height, size.width, size.height-50);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  //true if a new instance in getClip is created, to compare with the old instance and reload the chnages
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ItemTestList {
  final String ora;
  final String gradi;

  ItemTestList({this.ora, this.gradi});
}
