find_path(SODIUM_ROOT_DIR
    NAMES
        include/sodium.h
)

find_path(SODIUM_INCLUDE_DIR
    NAMES
        sodium.h
    HINTS
        ${SODIUM_ROOT_DIR}/include
)

find_library(SODIUM_LIBRARY
    NAMES
        sodium
    HINT
        ${SODIUM_ROOT_DIR}/lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SODIUM DEFAULT_MSG SODIUM_INCLUDE_DIR SODIUM_LIBRARY)
if(SODIUM_FOUND)
    set(SODIUM_INCLUDE_DIRS ${SODIUM_INCLUDE_DIR})
    set(SODIUM_LIBRARIES ${SODIUM_LIBRARY})
else()
    set(SODIUM_INCLUDE_DIRS)
    set(SODIUM_LIBRARIES)
endif()

include(CheckCSourceCompiles)
set(CMAKE_REQUIRED_LIBRARIES ${SODIUM_LIBRARY})
check_c_source_compiles("int main() {return 0;}" SODIUM_LINKS_SOLO)
set(CMAKE_REQUIRED_LIBRARIES)

include(CheckFunctionExists)
set(CMAKE_REQUIRED_LIBRARIES ${SODIUM_LIBRARY})
#TODO add more functions.
check_function_exists(sodium_version_string HAVE_VERSION_STRING)
set(CMAKE_REQUIRED_LIBRARIES)

mark_as_advanced(
    SODIUM_INCLUDE_DIR
    SODIUM_LIBRARY
)

