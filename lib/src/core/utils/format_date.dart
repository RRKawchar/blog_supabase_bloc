import 'package:intl/intl.dart';

String formatedDate(DateTime dateTime){
 return DateFormat("d MMM, yyyy").format(dateTime);
}