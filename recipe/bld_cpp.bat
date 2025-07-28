@echo off

md build2
cd build2
if %errorlevel% neq 0 exit /b %errorlevel%
cmake -GNinja -DBUILD_TESTING=OFF -DBUILD_DOCUMENTATION=OFF -DBUILD_GEN=ON ^
  -DBUILD_SHARED_LIBS:BOOL=ON ^
  -DCMAKE_VERBOSE_MAKEFILE=ON ^
  %CMAKE_ARGS% ^
  ..
if %errorlevel% neq 0 exit /b %errorlevel%
cmake --build . --config Release -j 2
if %errorlevel% neq 0 exit /b %errorlevel%
cmake --build . --config Release --target install
if %errorlevel% neq 0 exit /b %errorlevel%

