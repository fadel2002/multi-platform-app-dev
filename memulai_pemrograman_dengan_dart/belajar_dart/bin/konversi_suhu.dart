import 'dart:io';

void main() {
  stdout.write('Masukkan suhu dalam Fahrenheit: ');
  var fahrenheit = num.parse(stdin.readLineSync()!);
  var celsius = (fahrenheit - 32) * 5 / 9;
  var reamur = (fahrenheit - 32) * 4 / 9;
  var kelvin = (fahrenheit + 459.67) * 5 / 9;
  print(
      '$fahrenheit derajat Fahrenheit = '
      '$celsius derajat celsius = '
      '$reamur derajat reamur = '
      '$kelvin derajat kelvin'
  );
}