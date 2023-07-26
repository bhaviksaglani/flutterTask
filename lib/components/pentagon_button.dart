import 'dart:math';

import 'package:flutter/material.dart';

import '../screens/second_page.dart';

class PentagoneHeroButton extends StatelessWidget {
  const PentagoneHeroButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'blueButton',
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SecondPage()));
          },
          child: const AnimatedButton()),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isExpanded = false;
  double widthOfButton = 110;
  double heightOfButton = 110;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      AnimatedPositioned(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        onEnd: () {
          setState(() {
            widthOfButton = MediaQuery.of(context).size.width;
          });
        },
        width: widthOfButton,
        height: heightOfButton,
        left: _isExpanded ? MediaQuery.of(context).size.width / 2 - 50 : 0,
        top: _isExpanded
            ? 0
            : MediaQuery.of(context).size.height / 3 - 50, // Modified top value
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = true;
            });
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).push(_createRoute());
            });
          },
          child: const Center(
            child: CurvedPointedHexagonContainer(
              size: 70,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    ]);
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class CurvedPointedHexagonContainer extends StatelessWidget {
  final double size;
  final Color color;

  const CurvedPointedHexagonContainer({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: CurvedPointedHexagonPainter(color),
    );
  }
}

class CurvedPointedHexagonPainter extends CustomPainter {
  final Paint _paint;

  CurvedPointedHexagonPainter(Color color)
      : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;

    final path = Path();

    for (int i = 0; i < 6; i++) {
      final double x = centerX + radius * cos(2 * pi / 6 * i + pi / 6);
      final double y = centerY + radius * sin(2 * pi / 6 * i + pi / 6);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Calculate control points for the curved segment
        final double controlX =
            centerX + radius * cos(2 * pi / 6 * i + pi / 6 - pi / 12);
        final double controlY =
            centerY + radius * sin(2 * pi / 6 * i + pi / 6 - pi / 12);

        path.quadraticBezierTo(controlX, controlY, x, y);
      }
    }

    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
