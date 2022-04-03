class Player extends Obj {
  public Player(PVector p, float s, float sp, color c) {
    super(p, s, sp, c);
  }
  void update() {
    move(calc());
  }

  public int calc() {
    return 0;
  }

  void move(float dire) {
    dire = sign(dire) * min(abs(dire), 1);
    pos.x += dire * speed;
    if (pos.x + size >= width) {
      pos.x = width - size;
    }
    if (pos.x - size <= 0) {
      pos.x = size;
    }
  }
}
