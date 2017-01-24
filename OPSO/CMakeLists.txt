cmake_minimum_required(VERSION 2.8)
ADD_DEFINITIONS(
  -O0
  -Wall
  -g
  -std=c++11
)
project( opso )

add_executable( opso main.cpp opso.cpp opso.h )
target_link_libraries( opso )
