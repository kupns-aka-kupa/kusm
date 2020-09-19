cmake_minimum_required(VERSION 3.5)

project(ASMTemplate LANGUAGES CXX ASM_NASM)
enable_language(ASM_NASM)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -O2")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")
set(EXECUTABLE_OUTPUT_PATH "${PROJECT_SOURCE_DIR}/bin")

set(CMAKE_ASM_NASM_COMPILER "/usr/bin/nasm")
set(CMAKE_LINKER "/usr/bin/ld")
set(CMAKE_NASM_LINK_EXECUTABLE "ld <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_ASM_NASM_SOURCE_FILE_EXTENSIONS "asm;nasm;S")
set(CAN_USE_ASSEMBLER TRUE)

if(NOT CMAKE_ASM_NASM_OBJECT_FORMAT)
    if(WIN32)
        if(CMAKE_C_SIZEOF_DATA_PTR EQUAL 8)
            set(CMAKE_ASM_NASM_OBJECT_FORMAT win64)
        else()
            set(CMAKE_ASM_NASM_OBJECT_FORMAT win32)
        endif()
    elseif(APPLE)
        set(CMAKE_ASM_NASM_FLAGS "-DMACOS")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -macosx_version_min 10.13 -no_pie")
        if(CMAKE_C_SIZEOF_DATA_PTR EQUAL 8)
            set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
        else()
            set(CMAKE_ASM_NASM_OBJECT_FORMAT macho)
        endif()
    else()
        if(CMAKE_C_SIZEOF_DATA_PTR EQUAL 8)
            set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
        else()
            set(CMAKE_ASM_NASM_OBJECT_FORMAT elf)
        endif()
    endif()
endif()

link_directories(${PROJECT_NAME} ${SOURCE_DIR})

set(SOURCE_DIR "${PROJECT_SOURCE_DIR}/src")
configure_file(config.mac.in ${SOURCE_DIR}/config.mac)

file(GLOB SOURCE_FILES
    "${SOURCE_DIR}/*.asm"
    "${SOURCE_DIR}/*.mac"
)

add_executable(${PROJECT_NAME} ${SOURCE_FILES})

set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE NASM)
add_compile_options(${PROJECT_NAME} "-lc -I /lib/ld-linux.so.2")
target_include_directories(${PROJECT_NAME} PUBLIC
  ${SOURCE_DIR}
)

if(APPLE)
    target_link_libraries(${PROJECT_NAME} System)
endif(APPLE)
