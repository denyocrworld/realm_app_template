import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get yMd {
    return DateFormat("y-M-d").format(this);
  }

  String get dMMMy {
    return DateFormat("d MMM y").format(this);
  }

  String get dMMMykkss {
    return DateFormat("d MMM y kk:ss").format(this);
  }

  String get kkss {
    return DateFormat("kk:ss").format(this);
  }

  String get kkmm {
    return DateFormat("kk:mm").format(this);
  }
}
