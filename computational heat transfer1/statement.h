//
// Created by Administrator on 2023/12/24.
//

#ifndef COMPUTATIONAL_HEAT_TRANSFER_STATEMENT_H
#define COMPUTATIONAL_HEAT_TRANSFER_STATEMENT_H
#include<string>
#include<vector>
typedef struct {
    double xvalue;
    double yvalue;
    double zvalue;
}point;//point or vector
void input(const std::string &str,std::vector<point>&point_vector,std::vector<int *>&point_index);
int * array0(int length);
double module(const point &point1);
double inner_product(const point &point1,const point&point2);
double* cross_product(const point &point1,const point &point2);
double area(const std::vector<point>&point_vector0,const std::vector<int *>&point_index0);
void vector_get(const std::vector<point>&point_vector0,point &vector1,const int *ptr,const int &i,const int &j);
double volume(const std::vector<point>&point_vector0,const std::vector<int *>&point_index0);
void compute(std::basic_string<char> &file_location,std::vector<point>&point_sequence,std::vector<int *>&point_index0, double &area0, double &volume0);
#endif //COMPUTATIONAL_HEAT_TRANSFER_STATEMENT_H
