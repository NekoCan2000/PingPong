boolean left, right;

void inputUpdate() {
  if (mousePressed) {
    touched();
  } else {
    untouched();
  }
}
void touched() {
  left = mouseX < width/2;
  right = !left;
}

void untouched() {
  left = right = false;
}
