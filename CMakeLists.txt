cmake_minimum_required(VERSION 3.10)

project(mylib VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 17)

add_library(mylib src/mylib.cpp include/mylib.h)
target_include_directories(mylib PUBLIC include)

message(STATUS "=== Semantic Release Configuration ===")
message(STATUS "Project: ${PROJECT_NAME} v${PROJECT_VERSION}")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "=====================================")
