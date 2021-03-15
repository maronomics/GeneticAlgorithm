import java.util.Collections;
import java.util.Arrays;

public class Bunch {
  Circle[] Circles;
  int numCircles;
  Point[] openPoints = new Point[0];

  Bunch (int[] radii) {

    Circles = new Circle[radii.length];
    numCircles = radii.length;

    for (int i = 0; i < numCircles; i++) {
      Circles[i] = new Circle(radii[i], i);
    }
  }

  public void draw() {
    float bound = computeBoundary();
    stroke(0);
    fill(255);
    ellipse(cx, cy, bound * 2, bound * 2);

    for (int i = 0; i < numCircles; i++) {
      if (Circles[i].computed) {
        Circles[i].draw();
      }
    }

    for (int i = 0; i < openPoints.length; i++) {
      stroke(0, 255, 0);
      fill(0, 255, 0);
      point(openPoints[i].x, openPoints[i].y);
    }
  }

  float computeBoundary() {
    // Find bounding circle for circles
    int i;
    float outer_limit = 0;
    int furthest = 0;
    float distance = 0;

    for (i = 0; i < numCircles; i++) {
      if (Circles[i].computed) {
        distance = dist(cx, cy, Circles[i].x, Circles[i].y) + Circles[i].radius;
        if (distance >= outer_limit) {
          outer_limit = distance;
          furthest = i;
        }
      }
    }
    return (outer_limit);
  }

  public void orderedPlace() {
    for (int i = 0; i < numCircles; i++) {
      if (i == 0) {
        Circles[i].x = cx;
        Circles[i].y = cy;
        Circles[i].computed = true;
      } else {
        openPoints = Circles[i].computePosition(Circles);
      }
    }
  }

  public void greedyPlace() {

    //Selection Sort the Circles array based on radius and then draw them

    for (int i = 0; i < Circles.length-1; i++) {
      int maxIndex = i;  // largest element index
      for (int j = i + 1; j < Circles.length; j++) {
        if (Circles[j].radius > Circles[i].radius) {  // find largest element
          if (Circles[j].radius > Circles[maxIndex].radius)
            maxIndex = j; // update largest element index
        }
      }

      if (i != maxIndex) {  // swap
        Circle temp = Circles[maxIndex];
        Circles[maxIndex] = Circles[i];
        Circles[i] = temp;
      }
    }

    //for (int i = 0; i < Circles.length; i++) {
    //  println(i + " Circle radius: " + Circles[i].radius);
    //}

    for (int i = 0; i < numCircles; i++) {
      if (i == 0) {
        Circles[i].x = cx;
        Circles[i].y = cy;
        Circles[i].computed = true;
      } else {
        openPoints = Circles[i].computePosition(Circles);
      }
    }
  }

  public void geneticPlace(Population MyPopulation) {
    if (!MyPopulation.finished) {
      MyPopulation.evolve(generation);

      Individual best = MyPopulation.getBest();

      generation++;
      if (generation > MyPopulation.maxGens) {
        computed = true;
        background(255);

        for (int i = 0; i < numCircles; i++) {
          if (i == 0) {
            Circles[best.genome[i]].x = cx;
            Circles[best.genome[i]].y = cy;
            Circles[best.genome[i]].computed = true;
          } else {
            openPoints = Circles[best.genome[i]].computePosition(Circles);
          }
        }
        draw();
        fill(0);
        textFont(f, 16);
        text("GENETIC PLACEMENT", 50, 20);
        text("Bounding circle radius: " + computeBoundary(), 50, 50);
        println("Best Solution is: " + computeBoundary());
        println("Press DOWN key to restart.");
      }
    }
  }
}
