import 'dart:io';

void main(List<String> arguments) {
  // dartFundamentalControlFlow();
  // collections();
  // objectOrientedProgramming();
  // functionalStyles();
  // dartTypeSystems();
  // dartFutures();
  effectiveDart();
}

void effectiveDart(){
  func33();
}

void dartFutures(){
  func29();
  func30();
  func31();
  func32();
}

void dartTypeSystems(){
  func26();
  func27();
  func28();
}

void functionalStyles(){
  func23();
  func24();
  func25();
}

void objectOrientedProgramming(){
  func15();
  func16();
  func17();
  func18();
  func19();
  func20();
  func21();
  func22();
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
  bool isTrue = (2-1) == 4;
  if (isTrue) {
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
  print(shopStatus);
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

  List<dynamic>? list;
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

void func23(){
  var sum = (int num1, int num2) => num1 + num2;
  Function printLambda = () => print('This is lambda function');
  printLambda();
  print(sum(3, 4));
}

void func24(){
  void myHigherOrderFunction(
      String message,
      int Function(int num1, int num2) myFunction,
      ) {
    print(message);
    print(myFunction(3, 4));
  }
  // Opsi 1
  int Function(int num1, int num2) sum = (int num1, int num2) => num1 + num2;
  myHigherOrderFunction('Hello', sum);
  // Opsi 2
  myHigherOrderFunction('Hello', (num1, num2) => num1 + num2);
}

void func25(){
  Function calculate(base) {
    var count = 1;
    return () => print("Value is ${base + count++}");
  }
  var closureExample = calculate(2);
  closureExample();
  closureExample();
  closureExample();
}

void func26(){
  List<int> numberList = [1, 2, 3, 4, 5];
  List<String> stringList = ['Dart', 'Flutter', 'Android', 'iOS'];
  List dynamicList = [1, 2, 3, 'empat'];  // List<dynamic>
  
  print('${numberList.runtimeType} ${stringList.runtimeType} ${dynamicList.runtimeType}');
}

class Animala {}

class Birda implements Animala {}

class Dovea implements Birda {}

class Ducka implements Birda {}

void func27(){
  List<Birda> birdList = [Birda(), Dovea(), Ducka()];
  print(birdList);
}

void func28(){
  var x = 0;
  print(x.runtimeType);
}

void func29(){
  Future<String> getOrder() {
    return Future.delayed(Duration(seconds: 3), () {
      var isStockAvailable = false;
      if (isStockAvailable) {
        return 'Coffee Boba';
      } else {
        throw 'Our stock is not enough.';
      }
    });
  }
  getOrder().then((value) {
    print('Your ordered: $value');
  }).catchError((error) {
    print('Sorry. $error');
  }).whenComplete(() {
    print('Thank you');
  });
  print('Getting your order...');
}

void func30() async {
  Future<String> getOrder() {
    return Future.delayed(Duration(seconds: 3), () {
      return 'Coffee Boba';
    });
  }
  print('Getting your order...');
  var order = await getOrder();
  print('You order: $order');
}

void func31() async {
  Future<String> getOrder() {
    return Future.delayed(Duration(seconds: 3), () {
      var isStockAvailable = false;
      if (isStockAvailable) {
        return 'Coffee Boba';
      } else {
        throw 'Our stock is not enough.';
      }
    });
  }
  print('Getting your order...');
  try {
    var order = await getOrder();
    print('You order: $order');
  } catch (error) {
    print('Sorry. $error');
  } finally {
    print('Thank you');
  }
}

void func32() async {
  Future<String> fetchUsername() {
    return Future.delayed(Duration(seconds: 3), () => 'DartUser');
  }

  try {
    print('Fetching username...');
    var username = await fetchUsername();
    print('You are logged in as $username');
    print('Welcome!');
  } catch(e) {
    print(e);
  }
}

void func33(){
  // DO name types using UpperCamelCase.
    // abstract class Animal {}
    // abstract class Mammal extends Animal {}
    // mixin Flyable {}
    // class Cat extends Mammal with Walkable {}

  // DON’T use prefix letters.
    // var instance;  // good
    // var mInstance;  // bad

  // PREFER starting function or method comments with third-person verbs.
    // Returns `true` if [username] and [password] inputs are valid.
      // bool isValid(String username, String password) { }

  // PREFER a noun phrase for a non-boolean property or variable.
    // Good
      // cat.furColor;
      // calculator.firstNumber;
      // list.length;
    // Bad
      // list.deleteItems;
    // Use non-imperative noun for boolean variable or property
      // list.isEmpty
      // dialog.isOpen

  // DO use ?? to convert null to a boolean value.
  var stock;
  if(stock?.isEnough ?? false) {
    print('Making you a cup of coffee...');
  }

  // AVOID using curly braces in interpolation when not needed.
  var name = "Fadel", thisYear = 2024, birthYear = 2002;
  print('Hi, $name, You are ${thisYear - birthYear} years old.');

  // PREFER async/await over using raw futures.
    Future<String> getOrder() {
      return Future.delayed(Duration(seconds: 3), () {
        return 'Coffee Boba';
      });
    }
    // raw future
    void raw() {
      getOrder().then((value) {
        print('You order: $value');
      })
          .catchError((error) {
        print('Sorry. $error');
      });
      print('Getting your order...');
    }
    // async-await
    void asyncAwait() async {
      print('Getting your order...');
      try {
        var order = await getOrder();
        print('You order: $order');
      } catch (error) {
        print('Sorry. $error');
      }
    }
  // CONSIDER making the code read like a sentence.
    // Good
    // “If store is open ...”
    // if (store.isOpen)
    // “hey garfield, eat!”
    // garfield.eat();

    // Bad
    // Ambigu apakah memerintahkan toko untuk tutup atau mendapatkan status dari toko
    // if (store.close)

  // CONSIDER using function type syntax for parameters.
    // List filter(bool predicate(item)) { }
    // List filter(Function predicate) { }  // function type syntax
}