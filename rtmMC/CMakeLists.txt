# Generated Cmake Pico project file

cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Initialise pico_sdk from installed location
# (note this can come from environment, CMake cache etc)

# == DO NOT EDIT THE FOLLOWING LINES for the Raspberry Pi Pico VS Code Extension to work ==
if(WIN32)
    set(USERHOME $ENV{USERPROFILE})
else()
    set(USERHOME $ENV{HOME})
endif()
set(sdkVersion 2.2.0)
set(toolchainVersion 14_2_Rel1)
set(picotoolVersion 2.2.0-a4)
set(picoVscode ${USERHOME}/.pico-sdk/cmake/pico-vscode.cmake)
#set(picoVscode ${CMAKE_SOURCE_DIR}/external/pico-sdk)
if (EXISTS ${picoVscode})
	#include(${picoVscode})
endif()
# ====================================================================================
set(PICO_BOARD pico CACHE STRING "Board type")
set(PICO_SDK_PATH "${CMAKE_SOURCE_DIR}/external/pico-sdk")
#set(picotool_DIR "${CMAKE_SOURCE_DIR}/external/picotool/build")
#set(PICOTOOL "${CMAKE_SOURCE_DIR}/external/picotool/build/picotool")

# Pull in Raspberry Pi Pico SDK (must be before project)
include(pico_sdk_import.cmake)

project(rtmMC C CXX ASM)

# Initialise the Raspberry Pi Pico SDK
pico_sdk_init()

# Add executable. Default name is the project name, version 0.1

add_executable(rtmMC rtmMC.c )

pico_set_program_name(rtmMC "rtmMC")
pico_set_program_version(rtmMC "0.1")

# Modify the below lines to enable/disable output over UART/USB
pico_enable_stdio_uart(rtmMC 0)
pico_enable_stdio_usb(rtmMC 1)

# Add the standard library to the build
target_link_libraries(rtmMC
        pico_stdlib
        hardware_i2c
        hardware_watchdog
        )

# Add the standard include files to the build
target_include_directories(rtmMC PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}
)

pico_add_extra_outputs(rtmMC)

