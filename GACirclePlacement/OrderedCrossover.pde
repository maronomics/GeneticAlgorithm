public class OrderedCrossover
{
  int[] parent1;
  int[] parent2;
  int[] offSpring;

  public OrderedCrossover(int[] parent1, int[] parent2)
  {
    this.parent1 = new int[parent1.length];
    this.parent2 = new int[parent2.length];
    this.offSpring = new int[parent1.length];
    for (int index = 0; index < parent1.length; index ++)
    {
      this.parent1[index] = parent1[index];
      this.parent2[index] = parent2[index];
      this.offSpring[index] = offSpring[index];
    }
  }

  private int[] getOffspring() {
    return offSpring;
  }

  private boolean containsGene(int gene, int[] genome) {
    for (int i = 0; i < genome.length; i++) {
      if (genome[i] == gene) {
       //   println("contains gene = " + gene);
        return true;
      }
    }
    return false;
  }

  public void doCrossover() {
    int startPos = int (random(parent1.length));
    int endPos = int (random(startPos+1, parent1.length));

    //println("startPos: " + startPos + " " + " endPos: " +endPos);

    // Copy parent 1 genome from starting position to ending position
    for (int i = 0; i < parent1.length; i++) {
      if (i >= startPos && i <= endPos) {
        offSpring[i] = parent1[i];
      }
    }
    //// print offSpring
    //println("OFFSPRING after parent 1 : ");
    //println();
    //for (int i = 0; i < offSpring.length; i++) {
    //  print(offSpring[i]+ "  ");
    //}
    //println();

    // copy genome from parent 2 after endPos
    for (int i = 0; i < parent2.length; i++) {
      if (i > endPos) {
        if (!containsGene(parent2[i], offSpring)) {
          offSpring[i] = parent2[i];
        } else if (containsGene(parent2[i], offSpring) || offSpring[i] == 0) {
          for (int j = 0; j < parent2.length; j++) {
            if (!containsGene(parent2[j], offSpring)) {
              offSpring[i] = parent2[j];
              break;
            }
          }
        }
      }
      else if (offSpring[i] == 0){
      for (int j = 0; j < parent2.length; j++) {
            if (!containsGene(parent2[j], offSpring)) {
              offSpring[i] = parent2[j];
              break;
            }
          }
      }
    }
    //// print offSpring
    //println("OFFSPRING after parent 2: ");
    //println();
    //for (int i = 0; i < offSpring.length; i++) {
    //  print(offSpring[i]+ "  ");
    //}
    //println();

  }
}
