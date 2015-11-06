find_path(
    JSONC_ROOT_DIR
    NAMES
        include/json.h
        include/json_tokener.h
)

find_path(JSONC_INCLUDE_DIR
    NAMES
        json.h
        json_tokener.h
    HINTS
        ${JSONC_ROOT_DIR}/include
)

find_library(JSONC_LIBRARY
    NAMES
        json-c
    HINTS
        ${JSONC_ROOT_DIR}/lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(JSONC DEFAULT_MSG
                                  JSONC_INCLUDE_DIR
                                  JSONC_LIBRARY)

if(JSONC_FOUND)
    set(JSONC_INCLUDE_DIRS ${JSONC_INCLUDE_DIR})
    set(JSONC_LIBRARIES ${JSONC_LIBRARY})
else()
    set(JSONC_INCLUDE_DIRS)
    set(JSONC_LIBRARIES)
endif()

include(CheckCSourceCompiles)
set(CMAKE_REQUIRED_LIBRARIES ${JSONC_LIBRARY})
check_c_source_compiles("int main( {return 0;}" JSONC_LINKS_SOLO)
set(CMAKE_REQUIRED_LIBRARIES)

include(CheckFunctionExists)
set(CMAKE_REQUIRED_LIBRARIES ${JSONC_LIBRARY})

check_function_exists(json_object_new_object HAVE_JSON_OBJECT_NEW_OBJECT)
check_function_exists(json_object_add_object HAVE_JSON_OBJECT_ADD_OBJECT)
set(CMAKE_REQUIRED_LIBRARIES)

mark_as_advanced(
    JSONC_INCLUDE_DIR
    JSONC_LIBRARY
)
