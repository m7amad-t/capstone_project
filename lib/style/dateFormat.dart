
  String getAppDateTime(DateTime date) {
    String min = date.minute < 10 ? "0${date.minute}" : date.minute.toString();
    return "${date.year}-${date.month}-${date.day}   ${date.hour}:$min";
  }

  String getAppDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }