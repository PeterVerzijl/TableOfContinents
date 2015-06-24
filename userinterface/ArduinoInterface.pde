import processing.serial.*;

/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-22          (the version of the package this class was first added to)
 */
public class ArduinoInterface {

  private String lastMessage = "";
  private Serial serial;

  private int continentHeights[];
  private color continentColors[];

  public ArduinoInterface(PApplet applet) {
    // Initialize the serial.
    String arduinoPort = Serial.list()[0];
    serial = new Serial(applet, arduinoPort, 9800);
    serial.bufferUntil('\n');
    // Init the varialbes

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
      float c = continentColors[i];
      int red = c >> 16 & 0xFF;
      int green = c >> 8 & 0xFF;
      int blue = c & 0xFF;
      message =
        str(red) + ',' +
        str(green) + ',' +
        str(blue) + ',' +
        str(continentHeights[i]) +
        'n';
    }
    // Send message
    lastMessage = message;
    serial.write(message);
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



  /**
   * Gets called upon any serial event.
   * <p>
   * Handles everything that relates to communication from arduino to processing.
   * @param variable The serial port that gets triggered.
   * @return void.
   */
  public void serialEvent(Serial port) {
    String s = port.readString();
    if (s.equals("R")) {
        sendString(lastMessage);
    }
    print(s);
  }
}
