class Measurement {
  String Sensor_name;
  double Value;
  String Unit;
  String? Optional_comment;

  Measurement(this.Sensor_name, this.Unit, this.Value, this.Optional_comment);

  void displayMeasurement() {
    if (Optional_comment != null) {
      print('$Sensor_name -> $Value -> $Unit ->$Optional_comment');
    } else {
      print('$Sensor_name ->$Value ->$Unit');
    }
  }
}

class Sensor {
  String Sensor_name;
  double? min;
  double? max;

  Sensor(this.Sensor_name, this.max, this.min);

  String checksensor(double v) {
    if (min != null && v <= min!) {
      return 'outside range';
    }
    if (max != null && v >= max!) {
      return 'outside range';
    } else {
      return 'OK';
    }
  }
}

class satellitetelematry {
  List<Measurement> measurement = [];

  void addmeasurement(Measurement m) {
    measurement.add(m);
  }

  void displayallmeasurement() {
    for (var m in measurement) {
      m.displayMeasurement();
    }
  }

  void findmeasurementforsensor(String sensorname) {
    for (var m in measurement) {
      if (sensorname == m.Sensor_name) {
        print('${m.Value} ${m.Unit}');
      }
    }
  }

  void calculatetheaverage(String sensorname) {
    double sum = 0;
    int count = 0;
    for (var m in measurement) {
      if (sensorname == m.Sensor_name) {
        sum += m.Value;
        count++;
      }
    }
    if (count > 0) {
      double avg = sum / count;
      print('average is : $avg');
    } else {
      print('no measurement');
    }
  }

  void checksensorvalue(Sensor s) {
    print('${s.Sensor_name} ${s.min} ${s.max}');

    for (var m in measurement) {
      if (s.Sensor_name == m.Sensor_name) {
        String result = s.checksensor(m.Value);
        print('${m.Value} ->$result');
      }
    }
  }
}

void main() {
  var tele = satellitetelematry();

  tele.addmeasurement(Measurement('temperature', '°C', 24.5, 'Normal'));

  tele.addmeasurement(Measurement('battery', '%', 87, null));

  tele.addmeasurement(Measurement('altitude', 'Km', 540, 'Stable'));

  tele.addmeasurement(Measurement('temperature', '°C', 27.2, null));

  tele.addmeasurement(Measurement('temperature', '°C', -5.0, null));

  tele.addmeasurement(Measurement('battery', '%', 15, 'Low battery'));

  tele.displayallmeasurement();

  tele.findmeasurementforsensor('temperature');

  tele.calculatetheaverage('temperature');

  var temp = Sensor('temperature', 50, 0);

  tele.checksensorvalue(temp);

  var batteryconfig = Sensor('battery', null, 20);

  tele.checksensorvalue(batteryconfig);
}
