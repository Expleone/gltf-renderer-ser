# Looks for the environment variable:
# OPTIX_TOOLKIT_PATH

# Sets the variables:
# OTK_INCLUDE_DIR

# DAR Currently only need the OMM baking headers and library.
# OTK_CUOMMBAKING_LIBRARY

# OptiXToolkit_FOUND

set(OPTIX_TOOLKIT_PATH $ENV{OPTIX_TOOLKIT_PATH})

if ("${OPTIX_TOOLKIT_PATH}" STREQUAL "")
  set(OPTIX_TOOLKIT_PATH "${LOCAL_3RDPARTY}/optix-toolkit")
endif()

find_path(OTK_INCLUDE_DIR NAMES OptiXToolkit/CuOmmBaking/CuOmmBaking.h
          PATHS "${OPTIX_TOOLKIT_PATH}/include" "${OPTIX_TOOLKIT_PATH}/OmmBaking/include")

message("OTK_INCLUDE_DIR = " "${OTK_INCLUDE_DIR}")

find_library(OTK_CUOMMBAKING_LIBRARY_RELEASE NAMES CuOmmBaking
  PATHS "${OPTIX_TOOLKIT_PATH}/lib/OptiXToolkit")
find_library(OTK_CUOMMBAKING_LIBRARY_DEBUG NAMES CuOmmBaking
  PATHS "${OPTIX_TOOLKIT_PATH}/debug/lib/OptiXToolkit" NO_DEFAULT_PATH)

# MSVC Debug and Release libraries have incompatible CRT/iterator settings.
# SelectLibraryConfigurations otherwise silently substitutes whichever exists.
if(WIN32 AND (OTK_CUOMMBAKING_LIBRARY_RELEASE OR OTK_CUOMMBAKING_LIBRARY_DEBUG))
  if(CMAKE_CONFIGURATION_TYPES)
    set(_otk_configs ${CMAKE_CONFIGURATION_TYPES})
  elseif(CMAKE_BUILD_TYPE)
    set(_otk_configs "${CMAKE_BUILD_TYPE}")
  else()
    set(_otk_configs Release)
  endif()
  foreach(_otk_config IN LISTS _otk_configs)
    string(TOUPPER "${_otk_config}" _otk_config_upper)
    if(_otk_config_upper STREQUAL "DEBUG")
      set(_otk_required OTK_CUOMMBAKING_LIBRARY_DEBUG)
    else()
      set(_otk_required OTK_CUOMMBAKING_LIBRARY_RELEASE)
    endif()
    if(NOT ${_otk_required})
      message(FATAL_ERROR "OptiX Toolkit has no matching ${_otk_config} CuOmmBaking library. Build/install that configuration (3rdparty.cmd builds both), or restrict CMAKE_CONFIGURATION_TYPES to the installed configurations. Expected Debug location: ${OPTIX_TOOLKIT_PATH}/debug/lib/OptiXToolkit")
    endif()
  endforeach()
endif()
include(SelectLibraryConfigurations)
select_library_configurations(OTK_CUOMMBAKING)

message("OTK_CUOMMBAKING_LIBRARY = " "${OTK_CUOMMBAKING_LIBRARY}")

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(OptiXToolkit DEFAULT_MSG OTK_INCLUDE_DIR OTK_CUOMMBAKING_LIBRARY)

mark_as_advanced(OTK_INCLUDE_DIR OTK_CUOMMBAKING_LIBRARY)

message("OptiXToolkit_FOUND = " "${OptiXToolkit_FOUND}")
