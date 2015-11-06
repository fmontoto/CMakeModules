find_path(
    CONFIG_ROOT_DIR
    NAMES
        include/libconfig.h
)

find_path(CONFIG_INCLUDE_DIR
    NAMES
        libconfig.h
    HINTS
        ${CONFIG_ROOT_DIR}/include
)

find_library(CONFIG_LIBRARY
    NAMES
        libconfig
    HINT
        ${CONFIG_ROOT_DIR}/lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CONFIG DEFAULT_MSG
                                  CONFIG_INCLUDE_DIR
                                  CONFIG_LIBRARY)

if(CONFIG_FOUND)
    set(CONFIG_INCLUDE_DIRS ${CONFIG_INCLUDE_DIR})
    set(CONFIG_LIBRARIES ${CONFIG_LIBRARY})
else()
    set(CONFIG_INCLUDE_DIRS)
    set(CONFIG_LIBRARIES)
endif()

include(CheckCSourceCompiles)
set(CMAKE_REQUIRED_LIBRARIES ${CONFIG_LIBRARY})
check_c_source_compiles("int main( {return 0;}" CONFIG_LINKS_SOLO)
set(CMAKE_REQUIRED_LIBRARIES)

include(CheckFunctionExists)
set(CMAKE_REQUIRED_LIBRARIES ${CONFIG_LIBRARY})

check_function_exists(config_init HAVE_CONFIG_INIT)
check_function_exists(config_root_setting HAVE_CONFIG_ROOT_SETTING)
set(CMAKE_REQUIRED_LIBRARIES)

mark_as_advanced(
    CONFIG_INCLUDE_DIR
    CONFIG_LIBRARY
)
