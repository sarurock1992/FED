cmake_minimum_required(VERSION 2.8)
ADD_DEFINITIONS(
  -O0
  -Wall
  -g
  -std=c++11
)
project( PSO )

add_executable( PSO main.cpp PSO.cpp PSO.h )
target_link_libraries( PSO )
