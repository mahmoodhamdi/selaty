import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';

class AddressListItem extends StatefulWidget {
  const AddressListItem({super.key});

  @override
  State<AddressListItem> createState() => _AddressListItemState();
}

class _AddressListItemState extends State<AddressListItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'افتراضي',
                      style: Styles.textStyle12Bold.copyWith(
                        color: primaryGreen,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              isClicked
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isClicked = false;
                        });
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            border: Border.all(color: primaryRed, width: 2)),
                        child: const Icon(
                          Icons.circle,
                          color: primaryRed,
                          size: 18,
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isClicked = true;
                        });
                      },
                      icon: const Icon(
                        Icons.circle_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
              const Text(
                'المـنـزل',
                style: Styles.textStyle16Bold,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.ellipsis,
                  size: 24,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ح حمدي فتحي الأشوح - ش داير الناحيه\n ح حمدي فتحي الأشوح -   ش المنوفيه',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle16Bold.copyWith(color: Colors.grey),
                ),
                Text(
                  ' الباجور - المنوفيه',
                  style: Styles.textStyle16Bold.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Text(
                  'جوال : ',
                  style: Styles.textStyle16Bold,
                ),
                Text(
                  '01019793768',
                  style: Styles.textStyle16Bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
