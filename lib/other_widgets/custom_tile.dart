// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTile extends StatefulWidget {
  final bool delBtn;
  final DocumentSnapshot snapshot;
  final Function(DocumentSnapshot) onTap;

  const CustomTile(
      {super.key,
      required this.delBtn,
      required this.snapshot,
      required this.onTap});

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        widget.onTap(widget.snapshot);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        height: height * 0.1,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.8),
            !widget.delBtn
                ? Colors.blueGrey.withOpacity(0.2)
                : Colors.redAccent.withOpacity(0.2),
          ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.snapshot.get('diseaseName'),
              style:
                  GoogleFonts.lato(fontSize: height * 0.03, letterSpacing: 2),
            ),
            MaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              child: widget.delBtn
                  ? IconButton(
                      onPressed: () {
                        widget.onTap(widget.snapshot);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 28,
                      ),
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: height * 0.032,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
