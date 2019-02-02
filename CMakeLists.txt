cmake_minimum_required(VERSION 2.8)

project ( lxml_poc C CXX )

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -std=c++11")

option(BUILD_LIBXML2 "Downloads and builds required libxml2 libraries" OFF)
add_subdirectory(third_party)

include_directories ( ${CMAKE_SOURCE_DIR} )
include_directories ( SYSTEM /usr/include/libxml2 )

add_executable ( appender append_data_to_node.cpp )
target_link_libraries ( appender xml2 )

