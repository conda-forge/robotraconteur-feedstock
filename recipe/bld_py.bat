@echo off

md build2
cd build2
if %errorlevel% neq 0 exit /b %errorlevel%
cmake -GNinja -DBUILD_TESTING=OFF -DBUILD_DOCUMENTATION=OFF -DBUILD_GEN=OFF -DBUILD_PYTHON3=ON ^
  -DBUILD_CORE=OFF -DCMAKE_BUILD_TYPE:STRING=Release -DBUILD_SHARED_LIBS:BOOL=ON ^
  -DPYTHON3_EXECUTABLE=%PYTHON% ^
  %CMAKE_ARGS% ^
  ..
if %errorlevel% neq 0 exit /b %errorlevel%
cmake --build . --config Release -j 4
if %errorlevel% neq 0 exit /b %errorlevel%
cd out\Python3 
if %errorlevel% neq 0 exit /b %errorlevel%
%PYTHON% -m pip install --no-deps --ignore-installed . -vv
if %errorlevel% neq 0 exit /b %errorlevel%
