class Artist {
  final String name;
  final List<String> genre;
  Artist({required this.name, this.genre = const []});
}

class Performance {
  final String stage;
  final Artist artist;
  final double start_time;
  final double end_time;

  Performance({
    required this.stage,
    required this.artist,
    required this.end_time,
    required this.start_time,
  });

  double get Duration {
    return end_time - start_time;
  }

  bool checkconflictperformance(Performance p, {double mingap = 0.0}) {
    if (stage != p.stage) {
      return false;
    }
    if (end_time + mingap <= p.start_time ||
        start_time >= p.end_time + mingap) {
      return false;
    } else {
      return true;
    }
  }
}

class festivalrule {
  final double minGap;
  final bool Overlap;
  final int? maxperfomance;
  final List<String>? allowstange;

  festivalrule({
    this.minGap = 0.0,
    this.Overlap = false,
    this.maxperfomance,
    this.allowstange,
  });
}

class festivalschedule {
  final festivalrule rule;
  final String festival_name;
  final List<Performance> performace = [];

  festivalschedule({required this.festival_name, required this.rule});

  int get totalperformance => performace.length; // an this it total performance

  double get totalhour {
    // this one it totalmuscie duration in hour
    double sum = 0;
    for (var p in performace) {
      sum += p.Duration;
    }
    return sum;
  }
}
