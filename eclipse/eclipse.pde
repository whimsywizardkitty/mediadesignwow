int numCircles = 30;
float[] x, y, dx, dy, sizes; 
PFont font;

void setup() {
  size(1300, 700);
  font = createFont("JMH Typewriter", 30);
 

  // Initialize position, velocity, and size arrays
  x = new float[numCircles];
  y = new float[numCircles];
  dx = new float[numCircles];
  dy = new float[numCircles];
  sizes = new float[numCircles];

  // Randomly initialize positions, velocities, and sizes
  for (int i = 0; i < numCircles; i++) {
    x[i] = random(width);
    y[i] = random(height);
    dx[i] = random(-2, 2);
    dy[i] = random(-2, 2);
    sizes[i] = random(40, 100); 
  }
}

void draw() {
  background(0); // Black background
  
  
  fill(255, 255, 255);
   textSize(30);
 textFont(font);
text("e c l i p s e", 40, 120); 


  // Eclipse displacement based on mouse position
  float eclipseSize = map(mouseX, 0, width, 0, 80); // Size of the eclipse based on mouseX
  
  // Move and draw circles with crescent effect
  for (int i = 0; i < numCircles; i++) {
    x[i] += dx[i];
    y[i] += dy[i];

    // Wrap around logic
    if (x[i] < -50) x[i] = width;
    if (x[i] > width) x[i] = -50;
    if (y[i] < -50) y[i] = height;
    if (y[i] > height) y[i] = -50;

    // Draw the main circle (white circle)
    fill(255);
    noStroke();
    ellipse(x[i], y[i], sizes[i], sizes[i]); // Use random size for the circle

    // Draw the eclipsing circle (black circle)
    fill(0);
    ellipse(x[i] + eclipseSize, y[i], sizes[i], sizes[i]); // Eclipse moves in from the right
  }
}
