public class CalibrationScreen {
  
  public boolean active = true;        // If the calibration screen should be shown
  private int margin = 50;             // Margin on both sides of the screen
  
  // Spinner variables
  private float angle = 0;             // The angle of the spinner
  private float rotationSpeed = 0.2;   // The rotation speed of the spinner
  
  // Constructor
  public CalibrationScreen() {}
  
  // Main drawing function
  public void draw() {
    // Add to angle to make rotate
    angle += rotationSpeed;
    angle %= TWO_PI;
    
    pushStyle();
      // Draw transparent rectangle
      noStroke();
      fill(0, 10, 20, 230);
      rect(margin, margin, width - margin * 2, height - margin * 2);
      
      pushMatrix();
        translate(width*0.5, height*0.5);
        
        // Draw the waiting text
        fill(255);
        noStroke();
        textAlign(CENTER);
        text("Please wait, calibrating...", 0, -100);
        
        // Draw the rotating loading circle
        pushMatrix();
          rotate(angle);
          noFill();
          stroke(255);
          strokeWeight(4);
          arc(0, 0, 70, 70, HALF_PI*(sin(angle)+1), PI*(sin(angle)+1));
        popMatrix();
        
      popMatrix();
    popStyle();
  }
}
