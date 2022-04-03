class GM {
  Status status = Status.start;
  Ball ball;
  int playerPoint = 0, cpuPoint = 0;
  float timer = 0;

  GM(Ball b) {
    ball = b;
    ball.goalInTop.add(new Event() {
      public void invoke() {
        goal(0);
      }
    }
    );
    ball.goalInBottom.add(new Event() {
      public void invoke() {
        goal(1);
      }
    }
    );
  }
  void goal(int player) {
    playerPoint += 1-player;
    cpuPoint += player;
    status = Status.goal;
  }

  void update() {
    switch(status) {
    case start:
      timer += 1/frameRate;
      fill(255, abs(255-(255*(timer%2.0))));
      text("touch to start", width/2, height/2);
      if (timer >= 1 && mousePressed) {
        timer = 0;
        status = Status.game;
      }

      break;
    case game:
      fill(255);
      text(playerPoint+"", fontSize, height/2+fontSize);
      text(cpuPoint+"", fontSize, height/2-fontSize);
      break;
    case goal:
      fill(255, 0, 0);
      text(playerPoint+"", width/2, height/2+fontSize*2);
      text(cpuPoint+"", width/2, height/2-fontSize*2);

      timer += 1/frameRate;
      float a = abs(255-(255*(timer%2.0)));
      fill(255, a);
      text("touch to", width/2, height/2);
      float conY = height/2 + fontSize;
      fill(255);
      if (timer >= 2) {
        text("continue", width/2, conY);
        if (mousePressed) {
          timer = 0;
          status = Status.start;
          resetObj();
        }
      } else {
        text(ceil(2-timer)+"", width/2, conY);
      }
      break;
    }
  }
}
public enum Status {
  start, game, goal
}
