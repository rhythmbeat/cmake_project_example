#ExternalProject 관련 명령어 셋 추가
include(ExternalProject)

#Dependency 관련 변수 설정
set(DEP_INSTALL_DIR ${PROJECT_BINARY_DIR}/install)
set(DEP_INCLUDE_DIR ${DEP_INSTALL_DIR}/include)
set(DEP_LIB_DIR ${DEP_INSTALL_DIR}/lib)

# spdlog: fast logger library
ExternalProject_Add(
    dep_spdlog
    GIT_REPOSITORY "https://github.com/gabime/spdlog.git"
    #가져올 주소
    GIT_TAG "v1.x"
    #여러 버전, 브랜치 중 선택
    GIT_SHALLOW 1
    #1->true 가져오는 코드의 변경 내역을 다 다운받을 필요가 없음->과거들은 다 필요 없고 제일 최신 것만 다운받기 위해서
    #GIT_SHALLOW를 true로 해야한다
    UPDATE_COMMAND ""
    #깃 레퍼지토리를 클론을 클론을 통해 다운받고 이 프로젝트의 빌드를 어떻게 할 것인지, 
    #내가 다운받은 레포지토리의 원본이 최신 업데이트가 되었다. 그런데 우리는 그런 최신버전을 안 쓸 거니까 업데이트가 필요 없어서,
    #UPDATE_COMMAND를 없앤 것
    PATCH_COMMAND ""
    #PATCH_COMMAND는 다운받은 코드에서 무언가를 수정할 때 사용. 마찬가지로 그대로 쓸거라 없앰
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR}
    #cmake configure을 할 때 인자를 어떻게 줄 것인가를 세팅하는 코드 -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR}
    #cmake arguments(인자) '-D' definiton 즉, 변수를 의미. ${DEP_INSTALL_DIR}이게 변수에 대입할 값.
    #-DCMAKE_INSTALL_PREFIX=에서 CMAKE_로 시작하는 변수는 CMake가 특정해놓은, 미리 지정해놓은 변수들.
    #CMAKE_INSTALL_PREFIX->cmake가 인스톨을 다 했을때 어디에 인스톨(spdlog를 인스톨한 결과물을 넣을)할래? DEP_INSTALL_DIR
    #즉, PROJECT_BINARY_DIR안에 install이라는 폴더로 할 것이다.
    #PROJECT_BINARY_DIR 이건 빌드 폴더를 의미
    TEST_COMMAND ""
    #외부 라이브러리가 잘 만들어졌는지 검수는 생략, 자체 유닛 테스트를 위한 또 다른 라이브러리가 필요한 경우도 있고,
    #자체 유닛 테스트 시 빌드 시간이 훨씬 길어지기 때문
    #이 라이브러리가 완벽한지 내가 직접 검사할 필요는 없으니, 테스트 단계는 그냥 패스해!
    )
# Dependency 리스트 및 라이브러리 파일 리스트 추가
#외부 라이브러리를 추가할 때는 이 파일만 건드리면 된다
set(DEP_LIST ${DEP_LIST} dep_spdlog)
set(DEP_LIBS ${DEP_LIBS} spdlog$<$<CONFIG:Debug>:d>)

# glfw
ExternalProject_Add(
    dep_glfw
    GIT_REPOSITORY "https://github.com/glfw/glfw.git"
    GIT_TAG "3.4"
    GIT_SHALLOW 1
    UPDATE_COMMAND "" 
    PATCH_COMMAND "" 
    TEST_COMMAND ""
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR}
        -DGLFW_BUILD_EXAMPLES=OFF
        #glfw라이브러리 안에 있는 glfw 라이브러리를 이용해 만들어진 예제,
        -DGLFW_BUILD_TESTS=OFF
        #테스트 실행 파일,
        -DGLFW_BUILD_DOCS=OFF   
        #문서들을 끈 것
    )
set(DEP_LIST ${DEP_LIST} dep_glfw)
set(DEP_LIBS ${DEP_LIBS} glfw3)


# glad
ExternalProject_Add(
    dep_glad
    GIT_REPOSITORY "https://github.com/Dav1dde/glad"
    GIT_TAG "v0.1.34"
    GIT_SHALLOW 1
    UPDATE_COMMAND ""
    PATCH_COMMAND ""
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${DEP_INSTALL_DIR}
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
        -DGLAD_INSTALL=ON
    TEST_COMMAND ""
    )
set(DEP_LIST ${DEP_LIST} dep_glad)
set(DEP_LIBS ${DEP_LIBS} glad)