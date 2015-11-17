// Flocking
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, Spring 2011

// Flock class
// Does very little, simply manages the ArrayList of all the boids

class Flock {
  ArrayList<Boid> boids; 
  ArrayList<Boid> remove;
  ArrayList<Boid>[][] grid;
  int scl = 4;
  int cols, rows;
  
  Flock() {
    boids = new ArrayList<Boid>(); 
    remove = new ArrayList<Boid>();
    
    cols = width/scl;     // Calculate cols & rows
    rows = height/scl;    
    
    // Initialize grid as 2D array of empty ArrayLists
    grid = new ArrayList[cols][rows];
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j] = new ArrayList<Boid>();
      }
    }
  }

  void run(int pulse, PVector force) {
    // Every time through draw clear all the lists
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].clear();
      }
    }
    for(Boid b : boids) {
      b.highlight = false;
      int x = int(b.location.x) / scl; 
      int y = int (b.location.y) /scl;
      // It goes in 9 cells, i.e. every Thing is tested against other Things in its cell
      // as well as its 8 neighbors 
      for (int n = -1; n <= 1; n++) {
        for (int m = -1; m <= 1; m++) {
          if (x+n >= 0 && x+n < cols && y+m >= 0 && y+m< rows) grid[x+n][y+m].add(b);
        }
      }
    }
    
      for (int i = 0; i < cols; i++) {
    //line(i*scl,0,i*scl,height);
    for (int j = 0; j < rows; j++) {
      //line(0,j*scl,width,j*scl);
      
      // For every list in the grid
      ArrayList<Boid> temp = grid[i][j];
      // run every boid on its grid
      for (Boid b : temp) {
        b.run(temp, pulse);  // Passing the entire list of boids to each boid individually
        b.applyForce(force);
        if(b.lifespan < -20) {
          remove.add(b);
        }
      }
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