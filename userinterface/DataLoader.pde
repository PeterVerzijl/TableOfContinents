/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-22          (the version of the package this class was first added to)
 */
public class DataLoader {
    
  // Constructor
  public DataLoader() {}

  /**
   * Loads the data into the dataPoints variable.
   * <p>
   * Loads data from a text file at path 'filepath',
   * it assumes that it's seperator is a ';' semicolon.
   * <p>
   * @param variable The file path.
   * @return void.
   */
  public DataPoint[] load(String filepath) {
    // Return array
    DataPoint[] returnArray;

    String[] lines = loadStrings(filepath);
    // Check if we have any data at all
    if (lines == null) {
      println("Error, the file path is invalid.");
      return null;
    }

    // Initialize the dataPoints array
    returnArray = new DataPoint[lines.length - 1];

    // Loop trough all the rows (lines) to get the cells.
    // Start at the second line, since the first one only contains headers
    for (int i = 1; i < lines.length; i++) {
      // Get line
      String line = lines[i];
      // Split the line into cells (';' seperated values)
      String[] tableCells = splitTokens(line, ";");
      // Put data into a DataPoint.
      returnArray[i-1] = new DataPoint(
        tableCells[0],          // continentName
        float(tableCells[1]),   // drugRelatedDeaths
        int(tableCells[2]),     // GDP
        Long.parseLong(tableCells[3]),     // population
        int(tableCells[4]),     // UFOSightings
        int(tableCells[5]),     // homocideRate
        float(tableCells[6]),   // sexLifeSatisfaction
        float(tableCells[7]),   // overweight
        float(tableCells[8]),   // Amphetamine (next few are drugs)
        float(tableCells[9]),   // Canabis
        float(tableCells[10]),  // Cigarettes
        float(tableCells[11]),  // Cocain
        float(tableCells[12]),  // Ecstacy
        float(tableCells[13])   // Opiates
      );
    }
    return returnArray;
  }
}
