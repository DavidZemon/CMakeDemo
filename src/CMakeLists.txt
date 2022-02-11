# Zero-Clause BSD
#
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby
# granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
# AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

cmake_minimum_required(VERSION 3.9)


add_library(cmakedemo-lib CMakeDemo.cpp)
target_include_directories(cmakedemo-lib PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
    $<INSTALL_INTERFACE:include>
)

set_target_properties(cmakedemo-lib PROPERTIES OUTPUT_NAME cmakedemo)
install(TARGETS cmakedemo-lib EXPORT ${PROJECT_NAME}Config DESTINATION lib)

add_library(cmakedemo-cli-lib STATIC CMakeDemo-cli.cpp)
target_include_directories(cmakedemo-cli-lib INTERFACE "${CMAKE_CURRENT_LIST_DIR}")
target_link_libraries(cmakedemo-cli-lib cmakedemo-lib)

add_executable(cmakedemo main.cpp)
target_link_libraries(cmakedemo cmakedemo-cli-lib)
install(TARGETS cmakedemo DESTINATION bin)
