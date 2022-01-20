import 'package:intl/intl.dart';

readableDateTime(DateTime? dateTime) {
  try {
    String formattedDate = DateFormat('HH:mm, dd-MM-yyyy').format(dateTime!);
    return formattedDate;
  } catch(e) {
    return '';
  }
}

readableDate(DateTime dateTime) {
  try {
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  } catch(e) {
    return '';
  }
}

readableDateSlashddmmyyyy(DateTime dateTime) {
  if(dateTime == null)
    return '';
  try {
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  } catch(e) {
    return '';
  }
}

readableStringDateSlashddmmyyyy(String dateTimeString) {
  if(dateTimeString == null)
    return '';

  var dateTime = DateTime.parse(dateTimeString);
  try {
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  } catch(e) {
    return '';
  }
}

String getCurrentDateString() {
  var today = DateTime.now();
  return DateFormat('yyyy-MM-dd').format(today);
}


