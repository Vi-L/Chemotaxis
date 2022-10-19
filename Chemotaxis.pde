Predator[] predators = new Predator[1];
Prey[] preys = new Prey[1];

void setup() {
  size(750, 750);
  for (int i = 0; i < predators.length; i++) {
    predators[i] = new Predator(375, 375);
  }
  for (int i = 0; i < preys.length; i++) {
    preys[i] = new Prey(350, 350);
  }
}
void draw() {
  background(0, 128, 0);
  
  // behavior of predators
  for (int i = 0; i < predators.length; i++) {
    int targetIndex = predators[i].foundPrey(preys); // search for prey
    
    if (targetIndex != -1) { // if a prey is found
      predators[i].pursue(preys[targetIndex]);
      if (predators[i].myX == preys[targetIndex].myX && predators[i].myY == preys[targetIndex].myY) {
        predators[i].eat();
        preys = removedPreyArr(preys, targetIndex);
      }
    } else {
      predators[i].randomWalk();
    }
    // aging
    predators[i].age++;
    if (predators[i].age >= 500) {
      predators = removedPredatorArr(predators, i);
    }
    else if (predators.length > 0) {
      predators[i].show();
    }
  }
  
  // behavior of prey
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

void mousePressed() {
  if (mouseButton == LEFT) {
    predators = addedPredatorArr(predators, mouseX, mouseY);
  } else if (mouseButton == RIGHT) {
    preys = addedPreyArr(preys, mouseX, mouseY);
  }
}

class Prey {
  int myX, myY, myColor, myRange;
  Prey(int x, int y) {
    myX = x;
    myY = y;
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
    if (myX > prd.myX) myX += (int)(Math.random() * 21) - 7; // -7 to 13
    if (myX < prd.myX) myX += (int)(Math.random() * 21) - 13; // -13 to 7
    
    if (myY > prd.myY) myY += (int)(Math.random() * 21) - 7; // -7 to 13
    if (myY < prd.myY) myY += (int)(Math.random() * 21) - 13; // -13 to 7
  }
  void randomWalk() {
    myX += (int)(Math.random() * 21) - 10; // -10 to 10
    myY += (int)(Math.random() * 21) - 10; // -10 to 10
  }
  void show() {
    // borders
    if (myX < 0) myX = 0;
    if (myX > width) myX = width;
    if (myY < 0) myY = 0;
    if (myY > height) myY = height;
    
    noStroke();
    fill(128, 128, 128, 60);
    ellipse(myX, myY, myRange*2, myRange*2);
    fill(myColor);
    ellipse(myX, myY, 15, 15);
    
    textSize(20);
    fill(0, 0, 0);
    if ( foundPredator(predators) != -1) text("!", myX-5, myY+5);
  }
}

class Predator {
  int myX, myY, myColor, myRange, age;
  Predator(int x, int y) {
    myX = x;
    myY = y;
    myColor = color(227, 130, 2); // orange
    myRange = 125;
    age = 0;
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
    
    if (myX > pry.myX) myX += (int)(Math.random() * 11) - 7; // -7 to 3
    if (myX < pry.myX) myX += (int)(Math.random() * 11) - 3; // -3 to 7
    
    if (myY > pry.myY) myY += (int)(Math.random() * 11) - 7; // -7 to 3
    if (myY < pry.myY) myY += (int)(Math.random() * 11) - 3; // -3 to 7
  }
  void eat() {
    age = 0;
  }
  void randomWalk() {
    myX += (int)(Math.random() * 11) - 5; // -5 to 5
    myY += (int)(Math.random() * 11) - 5; // -5 to 5
  }
  void show() {
    // borders
    if (myX < 0) myX = 0;
    if (myX > width) myX = width;
    if (myY < 0) myY = 0;
    if (myY > height) myY = height;
    
    noStroke();
    fill(128, 128, 128, 60);
    ellipse(myX, myY, myRange*2, myRange*2);
    fill(myColor);
    ellipse(myX, myY, 30, 30);
    
    textSize(24);
    fill(255, 0, 0);
    if ( foundPrey(preys) != -1) text("!", myX-5, myY+5);
  }
}

// functions to ADD a predator or prey to their respective arrays
Predator[] addedPredatorArr(Predator[] ogArr, int x, int y) {
  Predator[] resArr = new Predator[ogArr.length + 1];
  for (int i = 0; i < ogArr.length; i++) {
    resArr[i] = ogArr[i];
  }
  resArr[resArr.length - 1] = new Predator(x, y);
  return resArr;
}

Prey[] addedPreyArr(Prey[] ogArr, int x, int y) {
  Prey[] resArr = new Prey[ogArr.length + 1];
  for (int i = 0; i < ogArr.length; i++) {
    resArr[i] = ogArr[i];
  }
  resArr[resArr.length - 1] = new Prey(x, y);
  return resArr;
}

// functions to REMOVE a predator or prey from their respective arrays
Predator[] removedPredatorArr(Predator[] ogArr, int badIndex) {
  Predator[] resArr = new Predator[ogArr.length - 1];
  int ogIndex = 0;
  int resIndex = 0;
  while (resIndex < resArr.length) {
    if (ogIndex != badIndex) {
      resArr[resIndex] = ogArr[ogIndex];
      resIndex++;
    }
    ogIndex++;
  }
  return resArr;
}

Prey[] removedPreyArr(Prey[] ogArr, int badIndex) {
  Prey[] resArr = new Prey[ogArr.length - 1];
  int ogIndex = 0;
  int resIndex = 0;
  while (resIndex < resArr.length) {
    if (ogIndex != badIndex) {
      resArr[resIndex] = ogArr[ogIndex];
      resIndex++;
    }
    ogIndex++;
  }
  return resArr;
}
