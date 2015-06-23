import processing.serial.*;

/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-22          (the version of the package this class was first added to)
 */
public class ArduinoInterface {

  private String lastMessage = "";
  private Serial serial;

  public ArduinoInterface(PApplet applet) {
    // Initialize the serial.
    String arduinoPort = Serial.list()[0];
    serial = new Serial(applet, arduinoPort, 9800);
    serial.bufferUntil('\n');
  }

  /**
   * Send a string to the aruino.
   * @param variable The string to send to arduino.
   * @return void.
   */
  public void sendString(String s) {
    lastMessage = s;
    serial.write(s);
  }

  public void sendLedMessage(Continent continent, color ledColor) {

  }

  /**
   * Gets called upon any serial event.
   * <p>
   * Handles everything that relates to communication from arduino to processing.
   * @param variable The serial port that gets triggered.
   * @return void.
   */
  void serialEvent(Serial port) {
    String s = port.readString();
    if (s.equals("R")) {
        sendString(lastMessage);
    }
    print(s);
  }
}
