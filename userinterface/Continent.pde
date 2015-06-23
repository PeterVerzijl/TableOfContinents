/**
 * @author      Peter Verzijl <peter @ verzijl.com>
 * @version     1.0                 (current version number of program)
 * @since       2015-06-23          (the version of the package this class was first added to)
 */
public class Continent {

    public String name = "";
    public int stepperCode = 0;
    public int ledCode = 0;
    public DataPoint dataPoint;
    
    public Continent(String name, int stepperCode, int ledCode, DataPoint dataPoint) 
    {
        this.name = name;
        this.stepperCode = stepperCode;
        this.ledCode = ledCode;
        this.dataPoint = dataPoint;
    }
}