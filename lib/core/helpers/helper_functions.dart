import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selaty/core/helpers/logger_helper.dart';

class THelperFunctions {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = const Color(0xFF323232),
    Color textColor = Colors.white,
  }) {
    LoggerHelper.info("Showing SnackBar: $message"); // Log SnackBar action

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: duration,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.yellow,
        onPressed: () {
          LoggerHelper.info("SnackBar dismissed by user."); // Log dismissal
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showAlert({
    required BuildContext context,
    required String title,
    required String message,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? primaryAction,
    VoidCallback? secondaryAction,
  }) {
    LoggerHelper.info(
        "Showing AlertDialog: Title - $title, Message - $message"); // Log Alert action

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            if (secondaryButtonText != null)
              TextButton(
                onPressed: secondaryAction ??
                    () {
                      LoggerHelper.info(
                          "Alert secondary button pressed: $secondaryButtonText");
                      Navigator.of(context).pop();
                    },
                child: Text(
                  secondaryButtonText,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ElevatedButton(
              onPressed: primaryAction ??
                  () {
                    LoggerHelper.info(
                        "Alert primary button pressed: ${primaryButtonText ?? 'OK'}");
                    Navigator.of(context).pop();
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                primaryButtonText ?? 'OK',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    LoggerHelper.info("Navigating to screen: ${screen.runtimeType}");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void popScreen(BuildContext context) {
    LoggerHelper.info("Popping current screen.");
    Navigator.pop(context);
  }

  static void navigateReplacementToScreen(BuildContext context, Widget screen) {
    LoggerHelper.info(
        "Navigating with replacement to screen: ${screen.runtimeType}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    LoggerHelper.debug("Truncating text to max length $maxLength.");
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    LoggerHelper.info("Is dark mode: $isDark");
    return isDark;
  }

  static Size screenSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoggerHelper.debug("Screen size: ${size.width}x${size.height}");
    return size;
  }

  static double screenHeight(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    LoggerHelper.debug("Screen height: $height");
    return height;
  }

  static double screenWidth(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    LoggerHelper.debug("Screen width: $width");
    return width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    String formattedDate = DateFormat(format).format(date);
    LoggerHelper.info("Formatted date: $formattedDate");
    return formattedDate;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    LoggerHelper.debug("Removing duplicates from list.");
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    LoggerHelper.debug("Wrapping widgets into rows of size $rowSize.");
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
