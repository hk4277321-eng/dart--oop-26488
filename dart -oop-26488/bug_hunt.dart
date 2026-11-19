class Phone {
  String _brand = '';
  int _battery = 0;

  Phone(String brand, int battery) {
    _brand = brand;
    _battery = battery;
  }

  String get brand => _brand;
  int get battery => _battery;

  set battery(int value) {
    if (value >= 0 && value <= 100) {
      _battery = value;
    } else {
      print('Error: battery must be 0 to 100');
    }
  }
}

class SmartPhone extends Phone {
  final String _system;

  SmartPhone(super.brand, super.battery, this._system);

  void restart() {
    print('Restarting $_system');
  }
}

void main() {
  Phone p = Phone('Tecno', 50);
  p.battery = 100;
  print('${p.brand}: ${p.battery}%');
}