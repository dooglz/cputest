cmake_minimum_required(VERSION 3.10)
if (MSVC)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP /EHsc" CACHE INTERNAL "" FORCE)
endif(MSVC)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(cpu_nbody_test CXX)
add_executable(main "main.cpp" "mathsandthings.h" "CLI11.hpp")

FIND_PACKAGE(OpenMP REQUIRED)
if(NOT ${OpenMP_CXX_FOUND})
  message(FATAL_ERROR "OpenMP  NOT FOUND")
endif()

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
