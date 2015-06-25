/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-23          (the version of the package this class was first added to)
 */
public class Continent {

    public String name = "";
    public DataPoint dataPoint;
    
    public Continent(String name, DataPoint dataPoint) 
    {
        this.name = name;
        this.dataPoint = dataPoint;
    }
}
