cmake_minimum_required(VERSION 3.25)
project(Jord LANGUAGES CXX)

# -------------------------------
# Options
option(JORD_USE_MODULES "Use C++20 modules instead of C++17 headers" ON)
option(BUILD_TESTS "Build Jord tests" OFF)


# Debug: show what CMake found
message(STATUS "JORD_HEADERS: ${JORD_HEADERS}")
message(STATUS "JORD_SOURCES: ${JORD_SOURCES}")
message(STATUS "JORD_MODULES: ${JORD_MODULES}")

# -------------------------------
# Library
if(JORD_USE_MODULES)
    file(GLOB_RECURSE JORD_MODULES CONFIGURE_DEPENDS "src/modules/*.ixx")
    file(GLOB_RECURSE JORD_MODULES_IMPL CONFIGURE_DEPENDS "src/modules/*.cpp")

    if(NOT JORD_MODULES)
        message(FATAL_ERROR "JORD_USE_MODULES=ON but no .ixx files found in src/")
    endif()

    message(STATUS "Jord: Building with C++20 modules")
    add_library(Jord STATIC ${JORD_MODULES} ${JORD_MODULES_IMPL})
    target_compile_features(Jord PUBLIC cxx_std_20)
    target_compile_definitions(Jord PUBLIC JORD_USE_MODULES)

    set_property(TARGET Jord PROPERTY CXX_SCAN_FOR_MODULES ON)

else()
    file(GLOB_RECURSE JORD_HEADERS CONFIGURE_DEPENDS "include/*.h" "include/*.hpp")
    file(GLOB_RECURSE JORD_SOURCES CONFIGURE_DEPENDS "src/cpp17/*.cpp")

    if(NOT JORD_SOURCES)
        message(FATAL_ERROR "JORD_USE_MODULES=OFF but no .cpp files found in src/")
    endif()

    message(STATUS "Jord: Building with C++17 headers")
    add_library(Jord STATIC ${JORD_SOURCES} ${JORD_HEADERS})
    target_compile_features(Jord PUBLIC cxx_std_17)
endif()

# Include directories
target_include_directories(Jord
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

# -------------------------------
# Tests
if(BUILD_TESTS)
    enable_testing()

    add_subdirectory(external/googletest)

    file(GLOB_RECURSE TEST_SOURCES CONFIGURE_DEPENDS "tests/*.cpp")

    add_executable(JordTests ${TEST_SOURCES})
    target_link_libraries(JordTests PRIVATE Jord gtest gtest_main)
    target_include_directories(JordTests PRIVATE include)

    # Pass the same macro to tests
    target_compile_definitions(JordTests PRIVATE
        $<$<BOOL:${JORD_USE_MODULES}>:JORD_USE_MODULES>
    )

    add_test(NAME JordTests COMMAND JordTests)
endif()

# -------------------------------
# Install
install(TARGETS Jord
    EXPORT JordConfig
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

install(DIRECTORY include/ DESTINATION include)
install(EXPORT JordConfig DESTINATION lib/cmake/Jord)