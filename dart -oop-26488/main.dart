class BusCard {
  String _owner = '';
  int _balance = 0;

  // Constructor
  BusCard(String owner, int balance) {
    _owner = owner;
    _balance = balance;
  }

  // Getter for owner
  String get owner {
    return _owner;
  }

  // TODO 1: read-only getter for balance
  int get balance {
    return _balance;
  }

  // Setter for owner with validation
  set owner(String newName) {
    if (newName.length < 3) {
      print('Error: name too short');
    } else {
      _owner = newName;
    }
  }

  void showInfo() {
    print('Owner: $_owner | Balance: $_balance RWF');
  }

  // TODO 2: topUp accepts 500 to 50000 RWF
  void topUp(int amount) {
    if (amount >= 500 && amount <= 50000) {
      _balance = _balance + amount;
      print('Topped up $amount RWF');
    } else {
      print('Error: top-up must be 500 to 50000 RWF');
    }
  }

  // TODO 3: pay is declined if fare > balance
  void pay(int fare) {
    if (fare > _balance) {
      print('Card declined');
    } else {
      _balance = _balance - fare;
      print('Paid $fare RWF');
    }
  }
}

class StudentCard extends BusCard {
  final int _discount;

  // Uses super parameters to satisfy the Dart linter
  StudentCard(super.owner, super.balance, this._discount);

  @override
  void showInfo() {
    super.showInfo();
    print('Student card: $_discount% off');
  }

  // TODO 4: apply discount, then call parent pay
  @override
  void pay(int fare) {
    int off = fare * _discount ~/ 100;
    print('Student discount: $off RWF');
    super.pay(fare - off);
  }
}

void main() {
  // My numbers: D = 88, L = 8
  // Starting balance = 1880 RWF, Bus fare = 288 RWF, Discount = 18%
  BusCard card = BusCard('Haneen', 1880);
  card.owner = 'Al'; // refused: name too short
  card.showInfo();

  // TODO 5
  card.owner = 'Haneen Khalid';
  card.showInfo();

  // TODO 6
  card.topUp(100); // refused
  card.topUp(2000);

  // TODO 7
  card.pay(288);
  card.pay(288);
  card.showInfo();

  // TODO 8
  StudentCard student = StudentCard('Haneen Khalid', 1880, 18);

  // TODO 9
  student.pay(288);
  student.showInfo();
}