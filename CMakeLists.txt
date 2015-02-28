project(psimpl-c)

set(HEADER_FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/psimpl-c.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/psimpl/psimpl.h")
set(SOURCE_FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/psimpl-c.cpp")

add_library(psimpl-c STATIC ${HEADER_FILES} ${SOURCE_FILES})
