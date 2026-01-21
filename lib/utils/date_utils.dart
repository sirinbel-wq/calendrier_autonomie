import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat.yMMMMd('fr_FR').format(date);
}