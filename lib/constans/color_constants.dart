import 'package:flutter/material.dart';

import '../utilities/hex_color.dart';


final kPrimaryColor = HexColor('FF39A0');
final ksecondaryColor = HexColor('343BAC');
final normalBlue = HexColor('3b71ca');
const whiteColor = Colors.white;
const blackColor = Colors.black;
final kyellowColor = HexColor('FEA64C');
final kpurupleColor = HexColor('443390');
final lightBlue = HexColor('87A2FF');
final lightcream = HexColor('A594F9');
final lightgreens = HexColor('6A9AB0');
final lighthardGreen = HexColor('697565');

final klightTextColor = HexColor('C6C6C6');
final blueShade2 = HexColor('12185DFF');
final blueShade3 = HexColor('03154ECF');
final greenShade = HexColor('008A7D');
// Color blueShade2 =    Colors.white;
// final darkBlue = HexColor('03154EFF');
//  Color darkBlue =    Colors.white.withOpacity(.3);
const appColor =    Color(0xFFfebd59 );
const darkBlue =    Color.fromRGBO(3, 21, 78, 1.0);
const darkBlue3 =    Color.fromRGBO(3, 21, 78, 0.8117647058823529);
const col = Color.fromRGBO(141, 0, 87, 0.596078431372549);
LinearGradient splashGradient = const LinearGradient(
  colors: [
    Color.fromRGBO(254, 30, 154, 0.7),
    Color.fromRGBO(37, 77, 222, 0.7)],
  begin: Alignment.topRight,
  end: Alignment.bottomCenter,
);    LinearGradient splashGradient2 = const LinearGradient(
  colors: [
    Color(0xFFffec00),
    Color(0xFFffec00),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomCenter,
);
LinearGradient splashGradientblur = const LinearGradient(
  colors: [Color.fromRGBO(251, 20, 150, 0.5), Color.fromRGBO(30, 77, 200, 0.7)],
  begin: Alignment.topRight,
  end: Alignment.bottomCenter,
);

LinearGradient authBgGradient = const LinearGradient(
    colors: [
      Color.fromRGBO(254, 166, 76, 0.4627450980392157),
      Color.fromRGBO(3, 21, 78, 0.6196078431372549),
      Color.fromRGBO(33, 3, 78, 0.3411764705882353),
      Color.fromRGBO(255, 255, 255, 0.4235294117647059),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    stops: [0, 0.35, 0.8, 1]);

LinearGradient circleListGradient =  LinearGradient(
    colors: [
      Color.fromRGBO(254, 166, 76, 1).withOpacity(.1),
      Color.fromRGBO(3, 21, 78, 1.0).withOpacity(.2),
      Color.fromRGBO(3, 21, 78, 1.0).withOpacity(.4),
      Color.fromRGBO(18, 93, 82, 1.0).withOpacity(.3),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    stops: [0, 0.33, 0.78, 1]);
LinearGradient snatang = const LinearGradient(
    colors: [
      Color.fromRGBO(254, 166, 76, 1),
      Color.fromRGBO(254, 30, 154, 1),
      Color.fromRGBO(245, 173, 10, 1.0),
      Color.fromRGBO(241, 16, 16, 1.0),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    stops: [0, 0.33, 0.5, 1]);





LinearGradient buttonGradient = LinearGradient(
  colors: [
    HexColor('FF39A0'),
    HexColor(
      'C32879',
    ),
  ],
  stops: const [0, 1],
);
LinearGradient yellowGradient = LinearGradient(
  colors: [
    HexColor('FEA64C'),
    HexColor('FEA64C'),
  ],
  stops: const [0, 1],
);
List<Shadow> grayTextShadow = <Shadow>[
  const Shadow(
    offset: Offset(1.0, 1.0),
    blurRadius: 3.0,
    color: Colors.grey,
  ),
  const Shadow(
    offset: Offset(1.0, 1.0),
    blurRadius: 8.0,
    color: Colors.grey,
  ),
];

LinearGradient scaffoldGradient = const LinearGradient(
  colors: [
    Color(0xff282561),
    Color(0xff080713),
  ],
  begin: Alignment.center,
  end: Alignment.bottomCenter,
);
LinearGradient headerGradient = const LinearGradient(
  colors: [
    Color.fromRGBO(65, 35, 111, 1),
    Color.fromRGBO(0, 0, 0, 0),
  ],
  begin: Alignment.center,
  end: Alignment.bottomCenter,
  stops: [0, 1],
);
LinearGradient rockOrRollGradient = const LinearGradient(
  colors: [
    Color.fromRGBO(237, 49, 147, 1),
    Color.fromRGBO(254, 166, 76, 1),
    Color.fromRGBO(237, 49, 147, 1),
    Color.fromRGBO(37, 77, 222, 1),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0, 0.01, 0.29, 1],
);

LinearGradient sliderGradient = const LinearGradient(
  colors: [
    Color.fromRGBO(0, 255, 255, 1),
    Color.fromRGBO(37, 77, 222, 1),
    Color.fromRGBO(237, 49, 147, 1),
    Color.fromRGBO(237, 49, 147, 1),
    Color.fromRGBO(254, 166, 76, 1),
  ],
);
// rgba(0, 255, 255, 1)
// rgba(37, 77, 222, 1)
// rgba(237, 49, 147, 1)
// rgba(237, 49, 147, 1)
// rgba(254, 166, 76, 1)