import 'package:flutter/material.dart';

class CurrentDetails extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;
  final double width;

  CurrentDetails(this.title, this.value, this.iconPath, this.width);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      //margin: EdgeInsets.symmetric(vertical: 12.5, horizontal: 8),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        child: Container(
          height: 85,
          width: width,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Colors.blue, width: 5)),
          ),
          child: ListTile(
            title: Text(title),
            subtitle: Text(value),
            trailing: Image.asset(
              iconPath,
              height: 48,
            ),
          ),
        ),
      ),
    );
  }
}
