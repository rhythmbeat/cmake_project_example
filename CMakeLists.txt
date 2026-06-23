cmake_minimum_required(VERSION 3.13)

set(PROJECT_NAME cmake_project_example)
set(CMAKE_CXX_STANDARD 17)

project(${PROJECT_NAME})
#이 유니코드 적용 코드는 내가 제미나이 보고 추가한 것
# MSVC(Visual Studio 컴파일러)를 사용할 때만 /utf-8 플래그를 추가함
if(MSVC)
    add_compile_options(/utf-8)
endif()

add_executable(${PROJECT_NAME} src/main.cpp)

include(Dependency.cmake)

# 우리 프로젝트에 include / lib 관련 옵션 추가
target_include_directories(${PROJECT_NAME} PUBLIC ${DEP_INCLUDE_DIR})
target_link_directories(${PROJECT_NAME} PUBLIC ${DEP_LIB_DIR})
target_link_libraries(${PROJECT_NAME} PUBLIC ${DEP_LIBS})

# Dependency들이 먼저 build 될 수 있게 관계 설정
add_dependencies(${PROJECT_NAME} ${DEP_LIST})