cmake_minimum_required(VERSION 3.14)

set(PROJECT_NAME opengl_example)
#cmake_projects_example라는 이름의 값을 담은 변수,
#PROJECT_NAME
set(CMAKE_CXX_STANDARD 17)
#cmake로 시작하는 (글로벌)변수->compile 옵션이 달라짐
#CXX는 C++과 동일한 말 C++ standard 가장 최신버전인
#17버전을 사용하겠다

set(WINDOW_NAME "OpenGL Example")
set(WINDOW_WIDTH 960)
set(WINDOW_HEIGHT 540)

project(${PROJECT_NAME})
#이런 이름의 프로젝트를 세팅할 것이다
# 그 다음에 옵션을 넣으세요
if(MSVC)
    add_compile_options(/utf-8)
endif()

add_executable(${PROJECT_NAME} src/main.cpp)
#$로 묶어야 단순 문자열이 아니라 값을 가져오는 것으로 인식
#PROJECT_NAME라는 이름의 실행 파일을 만들건데 뒤에 붙어있는
#모든 소스파일(src/main.cpp)을 컴파일해서 실행 파일을 만들 것이다
#src는 소스라고 부른다
#우리 소스코드에 어떤 것을 추가할 때는 이 부분만 건드리면 된다.

include(Dependency.cmake)




# 우리 프로젝트에 include / lib 관련 옵션 추가
target_include_directories(${PROJECT_NAME} PUBLIC ${DEP_INCLUDE_DIR})
#PROJECT_NAME 타겟의 이름(CMAKE_PROJECT_EXAMPLE을 담은 변수) 
target_link_directories(${PROJECT_NAME} PUBLIC ${DEP_LIB_DIR})
target_link_libraries(${PROJECT_NAME} PUBLIC ${DEP_LIBS})

target_compile_definitions(${PROJECT_NAME} PUBLIC
    WINDOW_NAME="${WINDOW_NAME}"
    WINDOW_WIDTH=${WINDOW_WIDTH}
    WINDOW_HEIGHT=${WINDOW_HEIGHT}
  )

# Dependency들이 먼저 build 될 수 있게 관계 설정
add_dependencies(${PROJECT_NAME} ${DEP_LIST})