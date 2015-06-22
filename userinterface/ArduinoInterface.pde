import processing.serial.*;

/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-22          (the version of the package this class was first added to)
 */
public class ArduinoInterface {

  private boolean handshaked = false;
  private Serial serial;

  public ArduinoInterface()
  {
    // Initialize the serial.
    String port = Serial.list()[0];
    serial = new Serial(this, port, 9800);
    serial.bufferUntil('\n');
  }

  public void update()
  {

  }

  void serialEvent(Serial port)
  {
    // Read buffer
    String val = port.readStringUntil('\n');
    // Check if our string isn't empty
    if (val == null
      return;
    // Trim whitespace
    val = trim(val);
    // Check for the "A" string.
    if (!handshaked)
    {
      if (val.equals("HANDSHAKE"))
      {
        port.clear();
        port.write("HANDSHAKE_OK");
        handshaked = true;
        println("Handshake successful");
      }
    }
    else
    {
      println("Arduino: " + val);
      // More code!!
    }
  }
}
