import java.util.Arrays;

Bunch OrderedCircles;
Bunch GreedyCircles;
Bunch GeneticCircles;
boolean computed;

int drawWhich = 0;

int w = 800;
int h = 600;

int cx = w/2;
int cy = h/2;
PFont f;
int size;
int generation;
float selectionPressure;
Population MyPopulation;

//int numCircles = 5;
//int[] radii = {10, 40, 25, 15, 18};
//int numCircles = 8;
//int[] radii = {10, 34, 10, 55, 30, 14, 70, 14};
//int numCircles = 10;
//int[] radii = {10, 12, 15, 20, 21, 30, 30, 30, 50, 40};
int numCircles = 20;
int[] radii = {10, 34, 10, 55, 30, 14, 70, 14, 50, 16, 23, 76, 34, 10, 12, 15, 16, 11, 48, 20};


void setup() {
  computed = false;

  size(800, 600);

  f = createFont("Arial", 16, true);

  OrderedCircles = new Bunch(radii);
  GreedyCircles = new Bunch(radii);
  GeneticCircles = new Bunch(radii);

  generation = 1;
  size = 20;
  selectionPressure = 0.5;
  MyPopulation = new Population(1000, 100, 0.010);
}

void draw() {
  switch (drawWhich) {
  case 1:
    if (!computed) {
      OrderedCircles.orderedPlace();
      computed = true;
      background(255);
      OrderedCircles.draw();
      fill(0);
      textFont(f, 16);
      text("ORDER-BASED PLACEMENT", 50, 20);
      text("Bounding circle radius: " + OrderedCircles.computeBoundary(), 50, 50);
      println("Order-based Placement");
      println("Best Solution is: " + OrderedCircles.computeBoundary());
    }
    break;  

  case 2:

    if (!computed) {
      GreedyCircles.greedyPlace();
      computed = true;
      background(255);
      GreedyCircles.draw();
      fill(0);
      textFont(f, 16);
      text("GREEDY PLACEMENT", 50, 20);
      text("Bounding circle radius: " + GreedyCircles.computeBoundary(), 50, 50);
      println("Greedy Placement");
      println("Best Solution is: " + GreedyCircles.computeBoundary());
    }
    break;

  case 3:
    if (!computed) {
      GeneticCircles.geneticPlace(MyPopulation);
    }
    break;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == DOWN) {
      computed = false;
      drawWhich = drawWhich + 1;
      // println(drawWhich);
    }
    if (drawWhich > 3) {
      setup();
      drawWhich = 1;
    }
  }
}
