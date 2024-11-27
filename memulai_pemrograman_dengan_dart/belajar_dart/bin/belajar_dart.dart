import 'dart:io';

void main(List<String> arguments) {
  // func1();
  // func2();
  // func3();
  // func4();
  // func5();
  func6();
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