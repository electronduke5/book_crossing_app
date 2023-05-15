import 'package:intl/intl.dart';

class DateTimeHelper {
  static String getDate(DateTime date) => DateFormat('dd.MM.yyyy').format(date);

  static String dateMonth(DateTime date) {
    date = date.toLocal();
    DateTime now = DateTime.now();
    int year = date.year;
    int month = date.month;
    int day = date.day;
    String time = DateFormat('HH:mm').format(date);
    String dateString = '$day ${_months[month - 1]}, $time';
    String dateStringWithYear = '$day ${_months[month - 1]} $year, $time';
    if (DateTime(now.year, now.month, now.day) == DateTime(year, month, day)) {
      return 'Сегодня, $time';
    }
    if (DateTime(now.year, now.month, now.day - 1) == DateTime(year, month, day)) {
      return 'Вчера, $time';
    }
    return now.year != year ? dateString : dateStringWithYear;
  }

  static const List<String> _months = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря'
  ];
}
