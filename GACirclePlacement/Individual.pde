
public class Individual {
  int[] genome;
  int genomeSize;
  double fitness; 

  Individual (int genomeSize) {
    this.genomeSize = genomeSize;
    genome = new int[genomeSize];

    //Create a index list of the numCircles
    int[] index = new int[genomeSize];
    for (int i = 0; i < index.length; i++) {
      index[i] = i;
    }

    //Scramble the indexes
    for (int i=0; i<index.length; i++) {
      int randomIndex = (int)(Math.random() * index.length);
      int temp = index[i];
      index[i] = index[randomIndex];
      index[randomIndex] = temp;
     // println(randomIndex);
    }

    //Copy scrambled indexes into genome
    for (int i = 0; i < index.length; i++) {
      genome[i] = index[i];
     // print(genome[i] + ", ");
    }
  }
  // constructor for when we want to insert a specified genome 
  // into the population (ie., when creating a child)
  Individual(int[] genes) { 

    this.genomeSize=genes.length;
    genome = new int[this.genomeSize];
    for (int i=0; i<genes.length; i++) {
      this.genome[i]=genes[i];
    }
  }

  void mutate(float mut_rate) {
    if (random(1)<mut_rate) {

      // flip two randomly selected genes
      int i, j;
      do {
        // pick mutation points, ensuring they are different
        i = (int)(Math.random() * genomeSize);
        j = (int)(Math.random() * genomeSize);
      } while (i!=j);

      // swap them over
      int t=genome[j];
      genome[j]=genome[i];
      genome[i]=t;
    }
  }

  // Fitness function
  void evaluateIndividual() {

    int[] radius = new int[genomeSize];
    for (int i = 0; i < genomeSize; i++) {
      radius[i] = radii[genome[i]];
    //  println(i+ " "+radius[i]);
    }

    Bunch Evaluate = new Bunch(radius);
    Evaluate.orderedPlace();
    fitness = Evaluate.computeBoundary();
    //println("fitness = " + fitness);
  }

}
