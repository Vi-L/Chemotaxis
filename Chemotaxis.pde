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
    int targetIndex = predators[i].foundPrey(preys);
    if (targetIndex != -1) {
      predators[i].pursue(preys[targetIndex]);
    } else {
      predators[i].randomWalk();
    }
    predators[i].show();
  }
  for (int i = 0; i < preys.length; i++) {
    int attackerIndex = preys[i].foundPredator(predators);
    if (attackerIndex != -1) {
      preys[i].flee(predators[attackerIndex]);
    } else {
      preys[i].randomWalk();
    }
    preys[i].show();
  }
}

class Prey {
  int myX, myY, myColor, myRange;
  Prey() {
    myX = myY = 400;
    myColor = color(255);
    myRange = 75;
  }
  int foundPredator(Predator[] preds) {
    for (int i = 0; i < preds.length; i++) {
      if (dist(preds[i].myX, preds[i].myY, myX, myY) <= myRange) {
        return i;
      }
    }
    return -1;
  }
  void flee(Predator prd) {
    if (myX > prd.myX) myX += (int)(Math.random() * 17) - 5;
    if (myX < prd.myX) myX += (int)(Math.random() * 17) - 12;
    
    if (myY > prd.myY) myY += (int)(Math.random() * 17) - 5;
    if (myY < prd.myY) myY += (int)(Math.random() * 17) - 12;
  }
  void randomWalk() {
    myX += (int)(Math.random() * 17) - 8;
    myY += (int)(Math.random() * 17) - 8;
  }
  void show() {
    // TODO: borders
    
    noStroke();
    fill(128, 128, 128, 90);
    ellipse(myX, myY, myRange*2, myRange*2);
    fill(myColor);
    ellipse(myX, myY, 15, 15);
    
    textSize(20);
    fill(0, 0, 0);
    if ( foundPredator(predators) != -1) text("!", myX-5, myY+5);
  }
}

class Predator {
  int myX, myY, myColor, myRange;
  Predator() {
    myX = myY = 375;
    myColor = color(227, 130, 2); // orange
    myRange = 150;
  }
  int foundPrey(Prey[] prys) {
    for (int i = 0; i < prys.length; i++) {
      if (dist(prys[i].myX, prys[i].myY, myX, myY) <= myRange) {
        return i;
      }
    }
    return -1;
  }
  void pursue(Prey pry) {
    
    if (myX > pry.myX) myX += (int)(Math.random() * 11) - 7;
    if (myX < pry.myX) myX += (int)(Math.random() * 11) - 3;
    
    if (myY > pry.myY) myY += (int)(Math.random() * 11) - 7;
    if (myY < pry.myY) myY += (int)(Math.random() * 11) - 3;
    
  }
  void randomWalk() {
    myX += (int)(Math.random() * 11) - 5;
    myY += (int)(Math.random() * 11) - 5;
  }
  void show() {
    // TODO: borders
    
    noStroke();
    fill(128, 128, 128, 90);
    ellipse(myX, myY, myRange*2, myRange*2);
    fill(myColor);
    ellipse(myX, myY, 30, 30);
    
    textSize(24);
    fill(255, 0, 0);
    if ( foundPrey(preys) != -1) text("!", myX-5, myY+5);
  }
}
