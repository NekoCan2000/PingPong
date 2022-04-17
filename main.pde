float fontSize = 80;
Ball ball;
Player player;
Player cpu;
GM gm;
void setup() {
  fullScreen();
  frameRate(30);
  textSize(fontSize);
  textAlign(CENTER);
  rectMode(CENTER);
  
  player = new Player(new PVector(width/2, height*0.9), 50, 10, color(0, 255, 0)) {
    @Override
      public int calc() {
      if (left) return -1;
      if (right) return 1;
      return 0;
    }
  };

  cpu = new Player(new PVector(width/2, height * 0.1), 50, 10, color(255, 0, 0)) {
    @Override
      public int calc() {
      float dire = ball.pos.x - this.pos.x;
      if (abs(dire) > this.speed) 
        return (int)dire;
      return 0;
    }
  };
  Player[] ps = {player,cpu};
  ball = new Ball(new PVector(width/2, height/2), 20, color(255),ps);
  gm = new GM(ball);
}

void resetObj() {
  ball.reset();
  player.reset();
  cpu.reset();
}

void draw() {
  background(0);
  switch(gm.status) {
  case start:
    PVector dire = ball.direction;
    float x = ball.pos.x;
    float y = ball.pos.y;
    strokeWeight(3);
    stroke(50,50,255);
    line(x, y, x+(dire.x*ball.size*2), y + (dire.y*ball.size*2));
    break;
  case game:

    inputUpdate();

    fill(150,150,50,150);
    if (left) {
      rect(width/4, height/2, width/2, height);
    }
    if (right) {
      rect(width-width/4, height/2, width/2, height);
    }



    ball.update();
    player.update();
    cpu.update();

    break;
  }

  objDraw();
  gm.update();
  //text(mouseX+","+mouseY,mouseX,mouseY);
}

float sign(float a) {
  return a > 0 ? 1 : (a == 0 ? 0 :-1);
}
void objDraw() {
  ball.draw();
  player.draw();
  cpu.draw();
}
