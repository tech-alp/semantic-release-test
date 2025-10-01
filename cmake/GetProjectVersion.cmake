# Function: get_project_version
#
# Description:
# Fetches the project version from the latest Git tag. If Git is not found or
# the current directory is not a Git repository, it defaults to "0.0.0".
#
# Parameters:
# - VERSION_VAR: The name of the variable in which the fetched or default version will be stored.
#
# Example Usage:
# get_project_version(PROJECT_VERSION)
# message(STATUS "Version: ${PROJECT_VERSION}")

function(get_project_version VERSION_VAR)
    find_package(Git QUIET)

    if(GIT_FOUND)
        execute_process(
            COMMAND ${GIT_EXECUTABLE} describe --tags --abbrev=0
            OUTPUT_VARIABLE GIT_TAG
            OUTPUT_STRIP_TRAILING_WHITESPACE
            ERROR_QUIET
            RESULT_VARIABLE TAG_RESULT
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        )

        if(TAG_RESULT EQUAL 0 AND GIT_TAG)
            message(STATUS "Found git tag: ${GIT_TAG}")
            string(REGEX REPLACE "^[vV]" "" STRIPPED_VERSION "${GIT_TAG}")
            string(REPLACE "-" ";" VERSION_LIST ${STRIPPED_VERSION})
            list(GET VERSION_LIST 0 VERSION_STRING)
            
            if(VERSION_STRING MATCHES "^[0-9]+\\.[0-9]+\\.[0-9]+")
                set(${VERSION_VAR} ${VERSION_STRING} PARENT_SCOPE)
                message(STATUS "Using version: ${VERSION_STRING}")
            else()
                set(${VERSION_VAR} "0.0.0" PARENT_SCOPE)
                message(STATUS "Invalid version format, using default: 0.0.0")
            endif()
        else()
            set(${VERSION_VAR} "0.0.0" PARENT_SCOPE)
            message(STATUS "No git tag found, using default version: 0.0.0")
        endif()
    else()
        set(${VERSION_VAR} "0.0.0" PARENT_SCOPE)
        message(STATUS "Git not found, using default version: 0.0.0")
    endif()
endfunction()
