import processing.serial.*;

/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-22          (the version of the package this class was first added to)
 */
public class ArduinoInterface {

  private boolean handshaked = false;
  private Serial serial;

  public ArduinoInterface(PApplet applet)
  {
    // Initialize the serial.
    String arduinoPort = Serial.list()[0];
    serial = new Serial(applet, arduinoPort, 9800);
    serial.bufferUntil('\n');
  }

  /**
   * Loads the data into the dataPoints variable.
   * <p>
   * Loads data from a text file at path 'filepath',
   * it assumes that it's seperator is a ';' semicolon.
   * <p>
   * @param variable The file path.
   * @return void.
   */
  public void update()
  {
    
  }
  
  public void SendString(String s) 
  {
    serial.write(s);
  }

  /**
   * Loads the data into the dataPoints variable.
   * <p>
   * Loads data from a text file at path 'filepath',
   * it assumes that it's seperator is a ';' semicolon.
   * <p>
   * @param variable The file path.
   * @return void.
   */
  void serialEvent(Serial port)
  {
    print(port.readString());
  }
}
