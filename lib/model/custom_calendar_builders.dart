import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarBuilders {
  final Color _borderColor = Colors.grey;

  Color _textColor(DateTime day) {
    const _defaultTextColor = Colors.black87;

    if (day.weekday == DateTime.sunday) {
      return Colors.red;
    }
    if (day.weekday == DateTime.saturday) {
      return Colors.blue;
    }
    return _defaultTextColor;
  }

  /// 曜日部分
  Widget daysOfWeekBuilder(BuildContext context, DateTime day) {
    // アプリの言語設定読み込み
    final locale = 'ja_JP';
    // アプリの言語設定に曜日の文字を対応させる
    final dowText =
        const DaysOfWeekStyle().dowTextFormatter?.call(day, locale) ??
            DateFormat.E(locale).format(day);

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        border: Border.all(
          width: 0.5,
          color: _borderColor,
        ),
      ),
      child: Center(
        child: Text(
          dowText,
          style: TextStyle(
            color: _textColor(day),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// 通常の日付部分
  Widget defaultBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return _CalendarCellTemplate(
      dayText: day.day.toString(),
      dayTextColor: _textColor(day),
      borderColor: _borderColor,
      textAlign: Alignment.topLeft,
    );
  }

  /// 有効範囲以外の日付部分
  Widget disabledBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return _CalendarCellTemplate(
      dayText: day.day.toString(),
      dayTextColor: Colors.grey,
      backgroundColor: Colors.grey.withOpacity(0.3),
      borderColor: _borderColor,
      textAlign: Alignment.topLeft,
    );
  }

  /// 選択された日付部分
  Widget selectedBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return _CalendarCellTemplate(
      dayText: day.day.toString(),
      dayTextColor: _textColor(day),
      backgroundColor: Colors.yellow.withOpacity(0.3),
      borderColor: _borderColor,
      textAlign: Alignment.topLeft,
    );
  }

  /// 今日の日付部分
  Widget todayBuilder(BuildContext context, DateTime day, DateTime focusedDay) {
    return _CalendarCellTemplate(
      dayText: day.day.toString(),
      dayTextColor: _textColor(day),
      backgroundColor: Colors.purpleAccent.withOpacity(0.3),
      borderColor: _borderColor,
      textAlign: Alignment.topLeft,
    );
  }

  /// 摂取値部分
  Widget markerBuilder(BuildContext context, DateTime day, event) {
    return Center(
      child: Text(
        '${event}g',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CalendarCellTemplate extends StatelessWidget {
  _CalendarCellTemplate({
    Key? key,
    String? dayText,
    Duration? duration,
    Alignment? textAlign,
    Color? dayTextColor,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
  })  : dayText = dayText ?? '',
        duration = duration ?? const Duration(milliseconds: 250),
        textAlign = textAlign ?? Alignment.topCenter,
        dayTextColor = dayTextColor ?? Colors.black87,
        backgroundColor = backgroundColor,
        borderColor = borderColor ?? Colors.black87,
        borderWidth = borderWidth ?? 0.5,
        super(key: key);

  final String dayText;
  final Color? dayTextColor;
  final Duration duration;
  final Alignment? textAlign;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor = Theme.of(context).colorScheme.primary;
    return AnimatedContainer(
      duration: duration,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor ?? defaultBorderColor,
          width: borderWidth,
        ),
      ),
      alignment: textAlign,
      child: Text(
        dayText,
        style: TextStyle(
          color: dayTextColor,
        ),
      ),
    );
  }
}
