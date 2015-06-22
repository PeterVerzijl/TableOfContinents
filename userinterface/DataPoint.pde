/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-22          (the version of the package this class was first added to)
 */
public class DataPoint {

  public String continentName = "Error";
  public float drugRelatedDeaths = 0.0f;
  public int GDP = 0;
  public int population = 0;
  public int UFOSightings = 0;
  public int homocideRate = 0;
  public float sexLifeSatisfaction = 0.0f;
  public float overweight = 0.0f;

  /**
   * Prints out the loaded data into a console.
   * <p>
   * Loads data from a text file at path 'filepath',
   * it assumes that it's seperator is a ';' semicolon.
   * <p>
   * @param variable void.
   * @return void.
   */
  public DataPoint(String _continentName, float _drugRelatedDeaths,
    int _GDP, int _population, int _UFOSightings, int _homocideRate,
    float _sexLifeSatisfaction, float _overweight)
  {
    continentName = _continentName;
    drugRelatedDeaths = _drugRelatedDeaths;
    GDP = _GDP;
    population = _population;
    UFOSightings = _UFOSightings;
    homocideRate = _homocideRate;
    sexLifeSatisfaction = _sexLifeSatisfaction;
    overweight = _overweight;
  }
}
