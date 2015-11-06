find_path(
    TCLIB_ROOT_DIR
    NAMES
        include/tc.h
)

find_path(TCLIB_INCLUDE_DIR
    NAMES
        tc.h
    HINTS
        ${TCLIB_ROOT_DIR}/include
)

find_library(TCLIB_LIBRARY
    NAMES
        tc
    HINTS
        ${TCLIB_ROOT_DIR}/lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TCLIB DEFAULT_MSG
                                  TCLIB_INCLUDE_DIR
                                  TCLIB_LIBRARY)

if(TCLIB_FOUND)
    set(TCLIB_INCLUDE_DIRS ${TCLIB_INCLUDE_DIR})
    set(TCLIB_LIBRARIES ${TCLIB_LIBRARY})
else()
    set(TCLIB_INCLUDE_DIRS)
    set(TCLIB_LIBRARIES)
endif()

include(CheckCSourceCompiles)
set(CMAKE_REQUIRED_LIBRARIES ${TCLIB_LIBRARY})
check_c_source_compiles("int main() {return 0;}" TCLIB_LINKS_SOLO)
set(CMAKE_REQUIRED_LIBRARIES)

include(CheckFunctionExists)
set(CMAKE_REQUIRED_LIBRARIES ${TCLIB_LIBRARY})

check_function_exists(tc_serialize_key_share HAVE_TC_SERIALIZE_KEY_SHARE_INIT)
check_function_exists(tc_join_signatures HAVE_TC_JOIN_SIGNATURES)
set(CMAKE_REQUIRED_LIBRARIES)

mark_as_advanced(
    TCLIB_INCLUDE_DIR
    TCLIB_LIBRARY
)
