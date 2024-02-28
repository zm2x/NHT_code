//
// Created by Administrator on 2023/12/26.
//
#include<string>
#include<vector>
#include"statement.h"
void compute(std::basic_string<char> &file_location,std::vector<point>&point_sequence,std::vector<int *>&point_index0, double &area0, double &volume0) {
    input(file_location,point_sequence,point_index0);
    area0=area(point_sequence,point_index0);
    volume0=volume(point_sequence,point_index0);
    point_sequence.clear();
    point_index0.clear();
}
