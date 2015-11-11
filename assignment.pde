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
    String[] parts = line.split(",");
    Renewable renewable = new Renewable();
    renewable.geo=parts[0];
    renewable.type=parts[2];
    if(
    renewable.consumption=Float.parseFloat(parts[4]);
    println(renewable.geo+"  "+renewable.type+"  "+renewable.consumption);
    //energyList.add(renewable);
  }
  /*for(String line:lines)
  {
    
  }*/
}
