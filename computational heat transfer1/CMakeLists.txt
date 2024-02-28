cmake_minimum_required(VERSION 3.25)
project(computational_heat_transfer)

set(CMAKE_CXX_STANDARD 17)

add_executable(computational_heat_transfer main.cpp function0.cpp statement.h computation.cpp)
