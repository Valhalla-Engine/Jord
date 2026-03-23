cmake_minimum_required(VERSION 3.15)
project(Jord LANGUAGES CXX)

option(BUILD_TESTS "Build Jord tests" OFF)

# -------------------------------
# Library sources
file(GLOB_RECURSE JORD_HEADERS "include/*.h" "include/*.hpp")
file(GLOB_RECURSE JORD_SOURCES "src/*.cpp")

add_library(Jord ${JORD_SOURCES} ${JORD_HEADERS})
target_include_directories(Jord PUBLIC include)
target_compile_features(Jord PUBLIC cxx_std_17)

# -------------------------------
# Optional tests
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(external/googletest)
    file(GLOB_RECURSE TEST_SOURCES "tests/*.cpp")
    add_executable(JordTests ${TEST_SOURCES})
    target_link_libraries(JordTests PRIVATE Jord gtest gtest_main)
    target_include_directories(JordTests PRIVATE include)
    add_test(NAME JordTests COMMAND JordTests)
endif()

# -------------------------------
# Install rules (optional)
install(TARGETS Jord
        EXPORT JordConfig
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin
)
install(DIRECTORY include/ DESTINATION include)
install(EXPORT JordConfig DESTINATION lib/cmake/Jord)