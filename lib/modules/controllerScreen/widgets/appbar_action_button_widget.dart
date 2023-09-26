import 'package:flutter/material.dart';

Widget buildAppbarActionButton(icon, onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(icon, size: 20, color: Colors.black,),
      ),
    ),
  );
}
