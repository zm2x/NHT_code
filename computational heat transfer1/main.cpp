#include"statement.h"
#include<string>
#include<iostream>
#include<iomanip>
#include<fstream>
#include<vector>
int main() {
    std::string file_location[12]={"Barrel_cup.obj","Bird_Toucan.obj","Cat.obj","Cup.obj","cylindsurf.obj","Dog.obj",
                                   "elephant.obj","Foot.obj","Pump.obj","Rooster.obj","Skull.obj","sphere-surf.obj"};
    std::string name[12]={"Barrel_cup","Bird_Toucan","Cat","Cup","cylindsurf","Dog",
                          "elephant","Foot","Pump","Rooster","Skull","sphere-surf"};
   double area[12];
   double volume[12];
   std::vector<point>point_sequence;
   std::vector<int *>point_index;
   std::ofstream fout;
   fout.open(R"(C:\Users\Administrator\Desktop\result.txt)",std::ios::out);
   for(int ii=0;ii<12;ii++) {
       file_location[ii] = R"(C:\Users\Administrator\Desktop\data\)" + file_location[ii];
       compute(file_location[ii], point_sequence, point_index, area[ii], volume[ii]);
       fout << "The area of " << name[ii] << " is ";
       fout << std::fixed << std::setprecision(4) << area[ii] << " smm" << "\n";
       fout << "The volume of " << name[ii] << " is ";
       fout << std::fixed << std::setprecision(4) << volume[ii] << " cmm" << "\n";
   }
   fout.close();
}
