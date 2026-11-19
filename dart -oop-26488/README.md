# Dart OOP Assignment: Kigali Bus Card

**Name:** Haneen Khalid
**Student ID:** 26488

## My numbers

- D = 88, L = 8
- Starting balance = 1000 + (88 × 10) = 1880 RWF
- Bus fare = 200 + 88 = 288 RWF
- Student discount = 10 + 8 = 18%

## Output of main.dart

```
Error: name too short
Owner: Haneen | Balance: 1880 RWF
Owner: Haneen Khalid | Balance: 1880 RWF
Error: top-up must be 500 to 50000 RWF
Topped up 2000 RWF
Paid 288 RWF
Paid 288 RWF
Owner: Haneen Khalid | Balance: 3304 RWF
Student discount: 51 RWF
Paid 237 RWF
Owner: Haneen Khalid | Balance: 1643 RWF
Student card: 18% off
```

## Part 1: Why no setter for balance?

A setter would let any code write `card.balance = 999999` and skip all the rules. The balance is money, so it must only change in the two safe ways: `topUp()` (which accepts only 500 to 50000 RWF) and `pay()` (which declines the payment if the fare is more than the balance). Without a balance setter, the field `_balance` is protected, and the rules in these methods cannot be bypassed. Other code can still read the balance with the getter, but it cannot change it directly.

## Part 2: What does ~/ do?

The `~/` operator is integer division: it divides and throws away the decimal part, so the result is an `int`. The normal `/` operator always gives a `double`.

```dart
print(237 * 17 / 100);   // 40.29  (double, keeps the decimals)
print(237 * 17 ~/ 100);  // 40     (int, the decimals are cut off)
```

Here `237 * 17 = 4029`, and `4029 / 100 = 40.29`, but `4029 ~/ 100 = 40`. In `StudentCard.pay()` I need `~/` because `off` is an `int` and money is counted in whole RWF. With my own numbers, `288 * 18 ~/ 100` is `51` (the exact value 51.84 is cut to 51).

## Part 4: Bug table

| Bug | The line | Why it is wrong (my words) | My fix |
|-----|----------|----------------------------|--------|
| 1 | `String _brand;` and `int _battery;` | The fields have no starting value. Dart does not allow a normal `String` or `int` to be empty (null), so the code does not compile. | Give them starting values: `String _brand = '';` and `int _battery = 0;` |
| 2 | `SmartPhone(String brand, int battery, String system) {` | The child constructor never builds the parent `Phone`. `Phone` needs a brand and a battery, so Dart gives an error. | Call the parent constructor: `SmartPhone(...) : super(brand, battery) {` |
| 3 | `@override` above `void restart()` | `@override` only works when the parent class has the same method. `Phone` has no `restart()`, so there is nothing to override. | Remove `@override`. `restart()` is a new method of `SmartPhone`. |
| 4 | `p.battery = 100;` | `Phone` has a getter for battery but no setter, so the value cannot be assigned. I kept this line, as the assignment says. | Add a setter that accepts only 0 to 100: `set battery(int value) { ... }` |
| 5 | `print(p.battery());` | `battery` is a getter, so it is used like a field, without `()`. With `()` Dart thinks I am calling a method. | Write `print(p.battery);` |

| Not a bug | Why is this line fine? |
|-----------|------------------------|
| `Phone p = new Phone('Tecno', 50);` | It looks old-fashioned, but in Dart the `new` keyword is optional. It is still allowed and works the same as `Phone('Tecno', 50)`. |

After the fixes, `bug_hunt.dart` prints `100`.

## Part 5

My prediction:

The program should print two numbers, `1` and then `5`.

- For `Bag a`: `a.add()` makes `_items` equal to 1. Then `a.items = -5` calls the setter, but the setter only accepts values that are 0 or more (`value >= 0`). Since -5 is smaller than 0, the value is refused and `_items` stays 1. So `print(a.items)` prints `1`.
- For `BigBag b`: `BigBag` overrides `add()` and calls `super.add()` two times, so one call to `b.add()` adds 2. After two calls, `_items` is 4. Then `b.items = b.items + 1` sets it to 5, and the setter accepts it because 5 is not negative. So `print(b.items)` prints `5`.

Real output:

```
1
5
```

Was I right?

Yes, my prediction was correct. The setter refused -5 for the normal `Bag`, and `BigBag.add()` added 2 each time because it calls `super.add()` twice.
