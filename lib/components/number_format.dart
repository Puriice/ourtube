class FormatNumber {
  final int num;

  FormatNumber({required this.num});

  String getFormatNumber() {
    String resultTimePass = '';
    String unit = num > 1 ? 'views' : 'view';

    if (num >= 10000000000) {
      resultTimePass = "${(num / 1000000000).toInt()}B";
    } else if (num >= 1000000000) {
      resultTimePass = "${(num / 1000000000).toStringAsFixed(1)}B";
    } else if (num >= 10000000) {
      resultTimePass = "${(num / 1000000).toInt()}M";
    } else if (num >= 1000000) {
      resultTimePass = "${(num / 1000000).toStringAsFixed(1)}M";
    } else if (num >= 1000) {
      resultTimePass = "${(num / 1000).toInt()}K";
    } else {
      resultTimePass = "$num";
    }

    return "$resultTimePass $unit";
  }
}
