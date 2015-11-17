// Flocking
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, Spring 2011

// Flock class
// Does very little, simply manages the ArrayList of all the boids

class Flock {
  ArrayList<Boid> boids; 
  ArrayList<Boid> remove;
  
  Flock() {
    boids = new ArrayList<Boid>(); 
    remove = new ArrayList<Boid>();;
  }

  void run(int pulse, PVector force) {
    for (Boid b : boids) {
      b.run(boids, pulse);  // Passing the entire list of boids to each boid individually
      b.applyForce(force);
      if(b.lifespan < -20) {
        remove.add(b);
      }
    }
    
    for (Boid b : remove) {
      boids.remove(b);
    }
    remove.clear();
  }

  void addBoid(Boid b) {
    boids.add(b);
  }

}