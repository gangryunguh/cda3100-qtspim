cmake_minimum_required(VERSION 3.5)
project(qtspim C)

set(CMAKE_C_STANDARD 11)

file (GLOB SOURCE_FILES *.c)

foreach(SOURCE_PATH ${SOURCE_FILES})
    get_filename_component(EXECUTABLE_NAME ${SOURCE_PATH} NAME_WE)
    add_executable(${EXECUTABLE_NAME} ${SOURCE_PATH})
endforeach ()
