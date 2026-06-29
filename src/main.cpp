#include <spdlog/spdlog.h>
#include <GLFW/glfw3.h>

int main(int argc, const char** argv){
    SPDLOG_INFO("Start program"); // 시작을 알리는 로그
    // glfw 라이브러리 초기화, 실패하면 에러 출력후 종료
    SPDLOG_INFO("Initialize glfw");
    if (!glfwInit()) {
        const char* description = nullptr;
        glfwGetError(&description);
        SPDLOG_ERROR("failed to initialize glfw: {}", description);
        return -1;
    }
    // glfw 윈도우 생성, 실패하면 에러 출력후 종료
    SPDLOG_INFO("Create glfw window");
    auto window = glfwCreateWindow(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_NAME, nullptr, nullptr);
    if (!window) {
        SPDLOG_ERROR("failed to create glfw window");
        glfwTerminate();
        return -1;
    }

    // glfw 루프 실행, 윈도우 close 버튼을 누르면 정상 종료
    SPDLOG_INFO("Start main loop");
    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();
    }
    //glfwWindowShouldClose(window)->윈도우가 닫혀야 하는지 여부를 반환, true이면 루프 종료, false(닫힐 이유가 없다면)이면 계속 루프
    //glfwPollEvents()->이벤트를 처리, 윈도우가 닫히는 이벤트가 발생하면 glfwWindowShouldClose(window)가 true를 반환하도록 설정

    glfwTerminate();
    return 0;
}
