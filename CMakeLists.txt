cmake_minimum_required(VERSION 3.15)

project(capnproto)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_custom_target(broker-capnp
    COMMAND capnp compile -oc++:. --src-prefix ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/broker.capnp
    DEPENDS broker.capnp
)

add_executable(main main.cpp)
add_dependencies(main broker-capnp)
target_include_directories(main PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries(main PRIVATE capnp kj)

