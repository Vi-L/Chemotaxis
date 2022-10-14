 Predator[] predators = new Predator[1];
Prey[] preys = new Prey[1];
void setup() {
  size(750, 750);
  for (int i = 0; i < predators.length; i++) {
    predators[i] = new Predator();
  }
  for (int i = 0; i < preys.length; i++) {
    preys[i] = new Prey();
  }
}
void draw() {
  background(0, 128, 0);
  for (int i = 0; i < predators.length; i++) {
    if (predators[i].foundPrey()) {
      predators[i].pursue();
    } else {
      predators[i].randomWalk();
    }
    predators[i].show();
  }
  for (int i = 0; i < preys.length; i++) {
    if (preys[i].foundPredator()) {
      preys[i].flee();
    } else {
      preys[i].randomWalk();
    }
    preys[i].show();
  }
}

class Prey {
  int myX, myY, myColor, myRange;
  Prey() {
    myX = myY = 375;
    myColor = color(255);
    myRange = 75;
  }
  boolean foundPredator() {
    if (dist(mouseX, mouseY, myX, myY) <= myRange) {
      return true;
    }
    return false;
  }
  void flee() {
    if (myX > mouseX) myX += (int)(Math.random() * 17) - 5;
    if (myX < mouseX) myX += (int)(Math.random() * 17) - 12;
    
    if (myY > mouseY) myY += (int)(Math.random() * 17) - 5;
    if (myY < mouseY) myY += (int)(Math.random() * 17) - 12;
  }
  void randomWalk() {
    myX += (int)(Math.random() * 17) - 8;
    myY += (int)(Math.random() * 17) - 8;
  }
  void show() {
    noStroke();
    fill(128, 128, 128, 90);
    ellipse(myX, myY, myRange*2, myRange*2);
    fill(myColor);
    ellipse(myX, myY, 15, 15);
    
    textSize(20);
    fill(0, 0, 0);
    if ( foundPredator() ) text("!", myX-5, myY+5);
  }
}

class Predator {
  int myX, myY, myColor, myRange;
  Predator() {
    myX = myY = 375;
    myColor = color(227, 130, 2); // orange
    myRange = 150;
  }
  boolean foundPrey() {
    if (dist(mouseX, mouseY, myX, myY) <= myRange) {
      return true;
    }
    return false;
  }
  void pursue() {
    
    if (myX > mouseX) myX += (int)(Math.random() * 11) - 7;
    if (myX < mouseX) myX += (int)(Math.random() * 11) - 3;
    
    if (myY > mouseY) myY += (int)(Math.random() * 11) - 7;
    if (myY < mouseY) myY += (int)(Math.random() * 11) - 3;
    
  }
  void randomWalk() {
    myX += (int)(Math.random() * 11) - 5;
    myY += (int)(Math.random() * 11) - 5;
  }
  void show() {
    noStroke();
    fill(128, 128, 128, 90);
    ellipse(myX, myY, myRange*2, myRange*2);
    fill(myColor);
    ellipse(myX, myY, 30, 30);
    
    textSize(24);
    fill(255, 0, 0);
    if ( foundPrey() ) text("!", myX-5, myY+5);
  }
}
