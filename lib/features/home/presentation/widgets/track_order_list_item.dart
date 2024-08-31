import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';

class TrackOrderListItem extends StatefulWidget {
  const TrackOrderListItem({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  State<TrackOrderListItem> createState() => _TrackOrderListItemState();
}

class _TrackOrderListItemState extends State<TrackOrderListItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isClicked = !isClicked;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: Styles.textStyle18Bold.copyWith(
                      color: isClicked ? primaryGreen : null,
                    ),
                  ),
                  Text(
                    isClicked
                        ? DateFormat.yMMMd().format(DateTime.now()).toString()
                        : 'قيد الانتظار',
                    style: Styles.textStyle16.copyWith(
                      color: isClicked ? Colors.black54 : Colors.grey,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: isClicked
                    ? primaryGreen.withOpacity(0.4)
                    : Colors.grey.withOpacity(0.4),
                radius: 30,
                child: Icon(
                  widget.icon,
                  color: isClicked ? primaryGreen : Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                width: 3,
                height: 30,
                color: isClicked ? primaryGreen : Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
