cmake_minimum_required(VERSION 2.8)
ADD_DEFINITIONS(
  -O0
  -Wall
  -g
  -std=c++11
)
project( mkgauss )

add_executable( mkgauss mkgauss.cpp )
target_link_libraries( mkgauss )
