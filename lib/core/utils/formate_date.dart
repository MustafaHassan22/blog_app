import 'package:intl/intl.dart';

String formateDate(DateTime dateTime) =>
    DateFormat('MMM d, y h:mm a').format(dateTime);
