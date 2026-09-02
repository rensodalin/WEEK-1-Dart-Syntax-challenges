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

  bool addperformance(Performance newperformance) {
    //first
    if (rule.maxperfomance != null &&
        performace.length >= rule.maxperfomance!) {
      print('cannot add');
      return false;
    }
    if (rule.allowstange != null &&
        !rule.allowstange!.contains(newperformance.stage)) {
      print('cannot add');
      return false;
    }

    if (!rule.Overlap) {
      for (var existing in performace) {
        if (newperformance.checkconflictperformance(
          existing,
          mingap: rule.minGap,
        )) {
          print('cannot add');
          return false;
        }
      }
    }
    performace.add(newperformance);
    print('add newperformance');
    return true;
  }

  void listallperformance(String stagename) {
    int count = 0;
    for (var p in performace) {
      if (stagename == p.stage) {
        print('${p.start_time} ->${p.end_time} ->${p.artist.name}');
        count++;
      }
    }
  }

  void findarhtist(String artiestname) {
    bool found = false;
    for (var p in performace) {
      if (artiestname == p.artist.name) {
        print('${p.artist.name} -> ${p.stage} ${p.start_time} ${p.end_time}');
        found = true;
      }
    }
    if (!found) {
      print('aritest not found');
    }
  }

  void calcualteinformation() {
    print('total performace : $totalperformance');
    print('total hour : $totalhour');
  }
}

void main() {
  var ruled = festivalrule(
    minGap: 0.25,
    maxperfomance: 5,
    Overlap: false,
    allowstange: ['stage a', 'stage b'],
  );
  var artist1 = Artist(name: 'Band 1', genre: ['Rock']);
  var artist2 = Artist(name: 'Band 2', genre: ['Pop']);
  var artist3 = Artist(name: 'Band 3', genre: ['Jazz']);

  var festival = festivalschedule(festival_name: "waterfestival", rule: ruled);

  festival.addperformance(
    Performance(
      stage: 'stage a',
      artist: artist1,
      end_time: 1.0,
      start_time: 12.0,
    ),
  );

  festival.addperformance(
    Performance(
      stage: 'stage c',
      artist: artist2,
      end_time: 2.00,
      start_time: 1.30,
    ),
  );

  festival.findarhtist('Band1');
  festival.listallperformance('stage a');
  festival.calcualteinformation();
}
