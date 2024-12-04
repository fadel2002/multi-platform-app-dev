import 'dart:io';

void main(List<String> arguments) {
  // dartFundamentalControlFlow();
  // collections();
  objectOrientedProgramming();
}

void objectOrientedProgramming(){
  // func15();
  // func16();
  // func17();
  // func18();
  // func19();
  // func20();
  // func21();
  func22();
  // func23();
  // func24();
  // func25();
  // func26();
  // func27();
  // func28();
}

void collections(){
  func12();
  func13();
  func14();
}

void dartFundamentalControlFlow(){
  func1();
  func2();
  func3();
  func4();
  func5();
  func6();
  func7();
  func8();
  func9();
  func10();
  func11();
}

void func1(){
  print('Hello Dart! Dart is great.');
  print('6 * 7 = ${calculate()}');

  var myAge;
  myAge = 20;
  print(myAge);

  String greetings = 'Hello Dart!';
  int myAgeInt = 20;
  print("${myAgeInt} ${greetings}");
}

int calculate() {
  return 6 * 7;
}

void func2(){
  stdout.write('Nama Anda : ');
  String name = stdin.readLineSync()!;
  stdout.write('Usia Anda : ');
  int age = int.parse(stdin.readLineSync()!);
  print('Halo $name, usia Anda $age tahun');
}

void func3(){
  // String -> int
  var eleven = int.parse('11');
  print(eleven.runtimeType);

  // String -> double
  var elevenPointTwo = double.parse('11.2');
  print(elevenPointTwo.runtimeType);

  // int -> String
  var elevenAsString = 11.toString();
  print(elevenAsString.runtimeType);

  // double -> String
  var piAsString = 3.14159.toStringAsFixed(2); // String piAsString = '3.14'
  print(piAsString.runtimeType);
}

void func4(){
  if (true) {
    print("It's true");
  } else {
    print("It's False");
  }
}

void func5(){
  print(5 + 2); // int add = 7
  print(5 - 2); // int subtract = 3
  print(5 * 2); // int multiply = 10
  print(5 / 2); // double divide = 2.5
  print(5 ~/ 2); // int intDivide = 2
  print(5 % 2); // int modulo = 1
}

void func6(){
  try {
    var a = 7;
    var b = 0;
    print(a ~/ b);
  } on Exception {
    print('Can not divide by zero.');
  }

  try {
    var a = 7;
    var b = 0;
    print(a ~/ b);
  } catch (e, s) {
    print('Exception happened: $e');
    print('Stack trace: $s');
  } finally {
    print('This line still executed');
  }
}

void func7(){
  double average(num num1, num num2) => (num1 + num2) / 2;
  void greeting() => print('Hello');
  void greetNewUser({String? name, int? age, bool? isVerified}){

  }
  void greetNewUserRequired({required String name, required int age, bool isVerified = false}) {

  }
  greetNewUser(name: "Fadel");
  greetNewUserRequired(name: "fadel", age: 11);
  print(average(1, 2));
  greeting();
}

void func8(){
  var openHours = 8;
  var closedHours = 21;
  var now = 17;

  if (now > openHours && now < closedHours) {
    print("Hello, we're open");
  } else {
    print("Sorry, we've closed");
  }

  var shopStatus = now > openHours ? "Hello, we're open" : "Sorry, we've closed";
}

void func9() {
  for (var i = 0; i < 10; i++) {
    print('hello ${i + 1}');
  }
}

void func10(){
  for (var i = 0; i < 10; i++) {
    print('hello ${i + 1}');
  }
}

void func11(){
  final firstNumber = 13;
  final secondNumber = 18;
  final operator = "+";

  switch (operator) {
    case '+':
      print(
          '$firstNumber $operator $secondNumber = ${firstNumber + secondNumber}');
      break;
    case '-':
      print(
          '$firstNumber $operator $secondNumber = ${firstNumber - secondNumber}');
      break;
    case '*':
      print(
          '$firstNumber $operator $secondNumber = ${firstNumber * secondNumber}');
      break;
    case '/':
      print(
          '$firstNumber $operator $secondNumber = ${firstNumber / secondNumber}');
      break;
    default:
      print('Operator tidak ditemukan');
  }
}

void func12(){
  List<int> numberList = [1, 2, 3, 4, 5];
  print(numberList.runtimeType);
  List stringList = ['Programming', 'Hello', 'Dicoding', 'Dart'];
  print(stringList.runtimeType);
  List dynamicList = [1, 'Dicoding', true];
  print(dynamicList.runtimeType);

  stringList.forEach((s) => print(s));
  stringList.remove('Programming');
  // stringList.removeAt(1);
  // stringList.removeLast();
  // stringList.removeRange(0,2);
  var spreadObject = [numberList, stringList];
  print(spreadObject);
  var spread = [...numberList, ...stringList];
  print(spread);

  List<dynamic>? list = [1, 2];
  List<dynamic>? list2 = [0, ...?list];
  print(list2);
}

void func13(){
  Set<int> numberSet = new Set.from([1, 4, 7, 4, 1]);
  print(numberSet);
  numberSet.add(6);
  numberSet.addAll({2, 2, 3});
  print(numberSet);
  numberSet.remove(3);
  print(numberSet);
  print(numberSet.elementAt(2));

  var setA = {1, 2, 4, 5};
  var setB = {1, 5, 7};
  var union = setA.union(setB);
  var intersection = setA.intersection(setB);
  print("union: $union");
  print("intersection: $intersection");
}

void func14(){
  var capital = {
    'Jakarta': 'Indonesia',
    'London': 'England',
    'Tokyo': 'Japan',
  };
  var mapKeys = capital.keys;
  print("mapKeys: $mapKeys");
  var mapValues = capital.values;
  print("mapValues: $mapValues");
  capital['New Delhi'] = 'India';
  print(capital);
}

class Animal {
  String _name = '';
  int _age = 0;
  double _weight = 0;

  Animal(this._name, this._age, this._weight);

  Animal.withMultiplier(this._name ,int age, double mult) {
    _age = (age * mult).toInt();
  }

  // Setter
  set name(String value) {
    _name = value;
  }

  // Getter
  String get name => _name;
  double get weight => _weight;
  int get age => _age;

  // Methods
  void eat() {
    print('$_name is eating.');
    _weight = _weight + 0.2;
  }

  void sleep() {
    print('$_name is sleeping.');
  }

  void poop() {
    print('$_name is pooping.');
    _weight = _weight - 0.1;
  }
}

void func15(){
  var dicodingCat = Animal('Gray', 2, 4.2);
  dicodingCat.eat();
  dicodingCat.poop();
  print(dicodingCat.weight);

  var dicodingDog = Animal.withMultiplier('Gray', 2, 5);
  print(dicodingDog.age);
  print(dicodingDog.weight);

  var dicodingEagle = (Animal('', 2, 4.2)
    ..name = 'Eagle'
    ..eat());
  print(dicodingEagle.name);
}

class Cat extends Animal {
  String furColor;
  Cat(super.name, super.age, super.weight, this.furColor);
  void walk() {
    print('$name is walking');
  }
  void changeFur(){
    this.furColor = "KCA";
  }
}

void func16(){
  var dicodingCat = Cat('Grayson', 2, 2.2, 'Gray');
  dicodingCat.walk();
  dicodingCat.eat();
  print(dicodingCat.weight);
}

class Flyablee {
  void fly() {}
}

class Bird extends Animal implements Flyablee {
  String featherColor;

  Bird(String name, int age, double weight, this.featherColor)
      : super(name, age, weight);

  @override
  void fly() {
    print('$name is flying');
  }
}

void func17(){
  var dicodingBird = Bird('Birdy', 2, 0.8, 'Gray');
  dicodingBird.fly();
  dicodingBird.eat();
}

enum Rainbow {
  red, orange, yellow, green, blue, indigo, violet
}

enum Weather {
  sunny, cloudy, rain, storm;
}

void func18(){
  print(Rainbow.values);
  print(Rainbow.blue);
  print(Rainbow.orange.index);
}

mixin Flyable {
  void fly() {
    print("I'm flying");
  }
}

mixin Walkable {
  void walk() {
    print("I'm walking");
  }
}

mixin Swimmable {
  void swim() {
    print("I'm swimming");
  }
}

void func19(){
  // class Cat extends Mammal with Walkable { }
  // class Duck extends Bird with Walkable, Flyable, Swimmable { }
}

abstract class Performer {
  void perform();
}

mixin Dancer implements Performer {
  @override
  void perform() {
    print('Dancing');
  }
}

mixin Singer implements Performer {
  @override
  void perform() {
    print('Singing');
  }
}

class Musician extends Performer with Dancer, Singer {
  void showTime() {
    perform();
  }
}

void func20(){
  // Singer karena mixin overide perform() paling terakhir
  var arielNoah = Musician();
  arielNoah.perform();
}

extension Sorting on List<int> {
  List<int> sortAsc() {
    var list = this;
    var length = this.length;
    for (int i = 0; i < length - 1; i++) {
      int min = i;
      for (int j = i + 1; j < length; j++) {
        if (list[j] < list[min]) {
          min = j;
        }
      }
      int tmp = list[min];
      list[min] = list[i];
      list[i] = tmp;
    }
    return list;
  }
}

void func21(){
  var unsortedNumbers = [2, 5, 3, 1, 4];
  print(unsortedNumbers);
  var sortedNumbers = unsortedNumbers.sortAsc();
  print(sortedNumbers);
}

class Car {
  String? color;
  String? fuelType;
  int? speed;
  int? maxSpeed;

  void accelerate() { }
  void brake() { }
  void refuel(num liters) { }
}

void func22(){
  var car = Car();
  print(car);
}