# Copyright (c) 2019 - 2022 Geode-solutions
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

cmake_minimum_required(VERSION 3.18)

#-------------------------------------------------------------------------------
# Project options
project(VTK CXX)

if(NOT DEFINED "ENV{PYTHON_PREFIX}")
    message(FATAL_ERROR "The `PYTHON_PREFIX` environment variable is required.")
endif ()

include(ExternalProject)

ExternalProject_Add(vtk
    PREFIX ${PROJECT_BINARY_DIR}/vtk
    URL https://www.vtk.org/files/release/9.1/VTK-9.1.0.tar.gz
    URL_HASH SHA256=8fed42f4f8f1eb8083107b68eaa9ad71da07110161a3116ad807f43e5ca5ce96
    CMAKE_GENERATOR ${CMAKE_GENERATOR}
    CMAKE_GENERATOR_PLATFORM ${CMAKE_GENERATOR_PLATFORM}
    CMAKE_ARGS
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_INSTALL_MESSAGE=LAZY
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_PREFIX_PATH=$ENV{PYTHON_PREFIX}
        -DCMAKE_BUILD_TYPE=Release
    CMAKE_CACHE_ARGS
        -DVTK_WRAP_PYTHON:BOOL=ON
        -DVTK_PYTHON_VERSION:STRING=3
        -DVTK_WHEEL_BUILD:BOOL=ON
        -DVTK_GROUP_ENABLE_Web:STRING=YES
        -DVTK_BUILD_TESTING:BOOL=OFF
        -DVTK_LEGACY_REMOVE:BOOL=ON
        -DPython3_FIND_STRATEGY:STRING=LOCATION
        -DPython3_EXECUTABLE:FILEPATH=$ENV{PYTHON_PREFIX}/bin/python
)
