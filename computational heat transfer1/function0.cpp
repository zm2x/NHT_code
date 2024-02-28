//
// Created by Administrator on 2023/12/24.
//
#include<string>
#include<iostream>
#include<fstream>
#include<sstream>
#include<vector>
#include<cmath>
#include"statement.h"
int * array0(int length){
    int *ptr=new int [length]();
    return ptr;
}
void input(const std::string &str, std::vector<point>&point_vector, std::vector<int *>&point_index){
    std::ifstream fin(str,std::ios::in);
    std::string line;
    std::string mark;
    while(getline(fin,line)){
        std::istringstream record(line);//extract abstract data from string
        record>>mark;
        if(mark=="v"){
            point point0;
            record>>point0.xvalue;
            record>>point0.yvalue;
            record>>point0.zvalue;
            point_vector.push_back(point0);
        }
        else if(mark=="f"){
            int *ptr0= array0(3);
            for(int ii=0;ii<3;ii++){
                record>>ptr0[ii];
                ptr0[ii]=ptr0[ii]-1;//the index of point is from one;
            }
            point_index.push_back(ptr0);
        }
    }
    fin.close();
}
double module(const point &point1){ //calculate the module of vector
    double module0= std::sqrt(std::pow(point1.xvalue,2)+std::pow(point1.yvalue,2)+std::pow(point1.zvalue,2));
    return module0;
}
double inner_product(const point &point1,const point&point2){
    double result0=point1.xvalue*point2.xvalue+point1.yvalue*point2.yvalue+point1.zvalue*point2.zvalue;
    return result0;
}
double* cross_product(const point &point1,const point &point2){
    auto *result1=new double[3];
    *result1=point1.yvalue*point2.zvalue-point2.yvalue*point1.zvalue;
    *(result1+1)=point2.xvalue*point1.zvalue-point1.xvalue*point2.zvalue;
    *(result1+2)=point1.xvalue*point2.yvalue-point2.xvalue*point1.yvalue;
    return result1;
}
void vector_get(const std::vector<point>&point_vector0,point &vector1,const int *ptr,const int &i,const int &j){
    vector1.xvalue=point_vector0[ptr[i]].xvalue-point_vector0[ptr[j]].xvalue;
    vector1.yvalue=point_vector0[ptr[i]].yvalue-point_vector0[ptr[j]].yvalue;
    vector1.zvalue=point_vector0[ptr[i]].zvalue-point_vector0[ptr[j]].zvalue;
}
double area(const std::vector<point>&point_vector0,const std::vector<int *>&point_index0){
    point vector1;
    point vector2;
    double area_sum=0.0;
    for(auto ptr:point_index0){
        vector_get(point_vector0,vector1,ptr,1,0);
        vector_get(point_vector0,vector2,ptr,2,0);
        double area0=std::sqrt(std::abs(std::pow(module(vector1),2)*std::pow(module(vector2),2)-std::pow(inner_product(vector1,vector2),2)))/2;
        area_sum=area_sum+area0;
    }
    return area_sum;
}

double volume(const std::vector<point>&point_vector0,const std::vector<int *>&point_index0){
    point vector2;
    point vector1;
    double volume_sum=0.0;
    for(auto ptr0:point_index0){
        vector_get(point_vector0,vector1,ptr0,1,0);
        vector_get(point_vector0,vector2,ptr0,2,0);
        auto *cross_pro= cross_product(vector1,vector2);
        double volume=std::abs(cross_pro[0]*point_vector0[*ptr0].xvalue+cross_pro[1]*point_vector0[*ptr0].yvalue+cross_pro[2]*point_vector0[*ptr0].zvalue)/6;
        volume_sum=volume_sum+volume;
    }
    return volume_sum;
}

