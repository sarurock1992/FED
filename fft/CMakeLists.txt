cmake_minimum_required(VERSION 2.8)
ADD_DEFINITIONS(
  -O0
  -Wall
  -g
  -std=c++11
)
project( a.out )

add_executable( a.out fft.h fft_function.cpp main.cpp )
target_link_libraries( a.out )
