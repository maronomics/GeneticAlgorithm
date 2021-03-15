class Population {
  boolean finished;
  Individual solution;
  Individual[] genomes;
  int maxGens;
  int popSize;
  float mutationRate;
  double currentBest;

  Population (int size, int maxgen, float mut) {
    popSize = size;
    mutationRate = mut;
    maxGens = maxgen;
    finished = false;
    currentBest = 99999999;

    genomes = new Individual[popSize];

    for (int popLoop = 0; popLoop < popSize; popLoop++) {
      genomes[popLoop] = new Individual(GeneticCircles.Circles.length);
    //  println(genomes[popLoop]);
    }
  }

  Individual Selection() {
    Individual[] pop = new Individual[size];
    double shortestCircle = 99999999;
    int shortestIndex = 0; // index of individual with shortest outer circle

    // pick a bunch of random genomes, and add to pop
    for (int i = 0; i < size; i++) {
      int randomID = (int) (Math.random() * popSize);
      pop[i] = genomes[randomID];
    }

    if (random(1)< selectionPressure) {
      for (int i = 0; i < size; i++) {
        if (pop[i].fitness < shortestCircle) {
          shortestCircle = pop[i].fitness;
          shortestIndex = i;
        }
      }
      return (pop[shortestIndex]);
    } else {
      return (pop[0]);
    }
  }
  
  Individual getBest(){
  return solution;
  }

  void evolve(int gen) {
    if (gen > maxGens) {
      finished = true;
    } else {
      // calculate fitnesses
      for (int popLoop = 0; popLoop < popSize; popLoop++) {
        genomes[popLoop].evaluateIndividual();
        double thisScore = genomes[popLoop].fitness;
        // if individual is the new best solution, copy it
        if (thisScore < currentBest) {
          solution = genomes[popLoop];
          currentBest = thisScore;
        }
      }
       println("After Generation = " + gen + ", the best fitness is: " + currentBest);
    }

    if (!finished) {
      // create a mating pool
      ArrayList<Individual> matingPool = new ArrayList<Individual>();

      //println("Adding to breeding pool...");
      for (int i = 0; i < popSize; i++) {
        matingPool.add(Selection());
      }

      //Create an offSpring
      //println("Creating offspring...");
      for (int i = 0; i < popSize; i++) {
        int a = int(random(matingPool.size()));
        int b = int(random(matingPool.size()));
        Individual parentA = matingPool.get(a);
        Individual parentB = matingPool.get(b);

        // do crossover
        OrderedCrossover Crossover = new OrderedCrossover(parentA.genome, parentB.genome);
        Crossover.doCrossover();
        int[] childGenome = Crossover.getOffspring();

        // create new child from crossover
        Individual child = new Individual(childGenome);

        //mutate child and add back to population
        child.mutate(mutationRate);
        genomes[i] = child;
      }
    }
  }
}
