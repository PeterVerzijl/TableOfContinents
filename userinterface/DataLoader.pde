/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-22          (the version of the package this class was first added to)
 */
public class DataLoader {

  public DataPoint[] dataPoints;

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
  public void load(String filepath)
  {
    String[] lines = loadStrings(filepath);
    // Check if we have any data at all
    if (lines == null)
    {
      println("Error, the file path is invalid.");
      return;
    }
    // Initialize the dataPoints array
    dataPoints = new DataPoint[lines.length];
    // Loop trough all the rows (lines) to get the cells.
    // Start at the second line, since the first one only contains headers
    for (int i = 1; i < lines.length; i++)
    {
      // Get line
      String line = lines[i];
      // Split the line into cells (';' seperated values)
      String[] tableCells = splitTokens(line, ";");
      // Put data into a DataPoint.
      datapoints[i-1] = new DataPoint(
        tableCells[0],          // continentName
        float(tableCells[1]),   // drugRelatedDeaths
        int(tableCells[2]),     // GDP
        int(tableCells[3]),     // population
        int(tableCells[4]),     // UFOSightings
        int(tableCells[5]),     // homocideRate
        float(tableCells[6]),   // sexLifeSatisfaction
        float(tableCells[7])   // overweight
      );
    }
  }

  /**
   * Prints out the loaded data into a console.
   * @param variable void.
   * @return void.
   */
  public void printData()
  {
    // Check if there is something to print in the first place.
    if (dataPoints == null || dataPoints.length <= 0)
    {
      println("Error, dataPoints is either null or empty. Initialize by calling DataLoader.Load();");
      return;
    }
    // Loop trough all the datapoints to print each one of them.
    for(DataPoint d : dataPoints)
    {
      println("DataPoint Name: " + d.continentName +
        ", drugs: " + d.drugRelatedDeaths +
        ", GDP: " + d.GDP +
        ", population: " + d.population +
        ", UFO: " + d.UFOSightings +
        ", homocideRate: " + d.homocideRate +
        ", sex: " + d.sexLifeSatisfaction +
        ", overweight: " + d.overweight + "."
      );
    }
  }
}
