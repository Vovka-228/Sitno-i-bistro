import 'dart:developer';

var CountsList = [];

int CartCounterr = 0;
int CartCounterr2 = 0;
int SummCounter = 0;
int count2 = 0;
int countMaps = 0;

int plusCartCounter() {
  SummCounter = CartCounterr + CartCounterr2;

  log("цифра: ${SummCounter}");
  return SummCounter;
}

void minCartCounter() {
  CartCounterr--;
  SummCounter--;
}

void plusCartCounter2() {
  CartCounterr2++;
  SummCounter++;
}

void minCartCounter2() {
  CartCounterr2--;
  SummCounter--;
}
