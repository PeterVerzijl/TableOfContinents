import processing.serial.*;

/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-22          (the version of the package this class was first added to)
 */
public class ArduinoInterface {

  private String lastMessage = "";
  private Serial serial;

  private int continentHeights[] = {0, 0, 0, 0, 0, 0};
  private color continentColors[] = {
    color(255, 0, 255),
    color(0, 0, 255),
    color(255, 0, 0),
    color(0, 255, 255),
    color(255, 255, 0),
    color(0, 255, 0)
  };
  
  public ArduinoInterface(PApplet applet) {
    // Initialize the serial.
    if (Serial.list().length <= 0) {
      println("Error, no arduino found!");
    }
    else {
      try {
      String arduinoPort = Serial.list()[0];
      serial = new Serial(applet, arduinoPort, 9800);
      serial.bufferUntil('\n');
      } catch (Exception e) 
      {
        println(e);
      }
    }
  }

  /* R, G, B, Height
   * int,int,int,int'n'...etc
   * if error has occured arduino returns an 'R'
   */

  /**
   * Send a message to the aruino containing all the data.
   * <p>
   * The data is fetched from continentColors and continentHeights.
   * These can be changed by calling SetDrugType & SetColors;
   */
  private void sendMessage() {
    // Build message for all the continents
    String message = "";
    for(int i = 0; i < continents.length; i++) {
      color c = continentColors[i];
      int r = (c >> 16) & 0xFF;      // Faster way of getting red(c);
      int g = (c >> 8) & 0xFF;
      int b = c & 0xFF;
      message +=
        str(r) + ',' +
        str(g) + ',' +
        str(b) + ',' +
        str(continentHeights[i]) +
        'n';
    }
    // Send message
    sendString(message);
  }

  /**
   * Sets the height data for the table continents from data.
   * <p>
   * The data is fetched from continentColors and continentHeights.
   * These can be changed by calling SetDrugType & SetColors;
   * @param data The data to translate into height.
   */
  public void SetDrugType(float[] data)
  {
    // Map the data correctly
    float min = min(data);
    float max = max(data);
    // Fill the data in the continent heights.
    for(int i = 0; i < continentHeights.length; i++)
      continentHeights[i] = (int)map(data[i], min, max, 0, 255);
    // Send data to arduino
    sendMessage();
  }

  /**
   * Set the color data for the table continents from data.
   * <p>
   * The data is fetched from continentColors and continentHeights.
   * These can be changed by calling SetDrugType & SetColors;
   * @param data The color data to send to the table.
   */
  public void SetColors(color[] data)
  {
    // Set the data.
    continentColors = data;
    // Send data to arduino
    sendMessage();
  }
  
  public void sendString(String s) {
    lastMessage = s;
    if (serial != null) serial.write(s);
    println("Serial: " + s);
  }
    
  
  /**
   * Gets called upon any serial event.
   * <p>
   * Handles everything that relates to communication from arduino to processing.
   * @param variable The serial port that gets triggered.
   * @return void.
   */
  public void serialEvent(Serial port) {
    String s = port.readString();
    if (s.equals("R\n")) {
      sendString(lastMessage);
    }
    else if (s.equals("READY\n")) {
      calibrationScreen.active = false;
    }
    print(s);
  }
}
