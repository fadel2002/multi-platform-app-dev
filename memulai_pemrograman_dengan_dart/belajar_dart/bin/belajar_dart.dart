import 'dart:io';

void main(List<String> arguments) {
  DartFundamental_ControlFlow();
  Collections();
}

void Collections(){
  // func12();
  // func13();
  // func14();
  // func15();
  // func16();
  // func17();
  // func18();
  // func19();
  // func20();
  // func21();
  // func22();
  // func23();
  // func24();
  // func25();
  // func26();
  // func27();
  // func28();
}

void DartFundamental_ControlFlow(){
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
}