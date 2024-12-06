PImage img1, img2, img3;
int numImages = 20; // Number of images to display per type
float scaleFactor = 0.3; // Scale factor to reduce image size


void setup() {
  size(900, 600);
  img1 = loadImage("most blurry.png");
  img2 = loadImage("middle.png");
  img3 = loadImage("least blurry.png");

}

void draw() {
  background(0); // Black background
  
  // Draw multiple images of each type
  for (int i = 0; i < numImages; i++) {
    // Random position for img1
    float x1 = random(width - img1.width * scaleFactor);
    float y1 = random(height - img1.height * scaleFactor);
    image(img1, x1, y1, img1.width * scaleFactor, img1.height * scaleFactor);
    
    // Random position for img2
    float x2 = random(width - img2.width * scaleFactor);
    float y2 = random(height - img2.height * scaleFactor);
    image(img2, x2, y2, img2.width * scaleFactor, img2.height * scaleFactor);
    
    // Random position for img3
    float x3 = random(width - img3.width * scaleFactor);
    float y3 = random(height - img3.height * scaleFactor);
    image(img3, x3, y3, img3.width * scaleFactor, img3.height * scaleFactor);
  }
  
  noLoop(); // Stop continuous drawing
}
