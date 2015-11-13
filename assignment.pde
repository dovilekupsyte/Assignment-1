void setup()
{
  size(500, 500);
  loadData();
}
//ArrayList<Renewable> energyList = new ArrayList<Renewable>();

void loadData()
{
  String[] lines= loadStrings("allenergy.tsv");
  
  for(String line:lines)
  {
    String[] parts = line.split("\t");
    Renewable renewable = new Renewable();
    renewable.geo=parts[0];
    renewable.type=parts[1];
    renewable.consumption = new float[parts.length];
    print("\n"+renewable.geo);
    
    for(int i=2; i<renewable.consumption.length; i++)
    {
      renewable.consumption[i]=Float.parseFloat(parts[i]);
      print(" "+renewable.consumption[i]);
    }
    
    //energyList.add(renewable);
  }
  /*for(String line:lines)
  {
    
  }*/
}
