find_package(Boost REQUIRED  system filesystem date_time regex thread)
find_package(dynamic_objects)
find_library(NAVIMATH_LIB NAMES NaviMath)

if(nav_components_FIND_COMPONENTS)
  foreach(component ${nav_components_FIND_COMPONENTS})
    string(TOUPPER ${component} component)
    if(component STREQUAL "NAV_KERNEL")
      list(APPEND nav_components_LIBRARIES nav_kernel)
    elseif(component STREQUAL "NAV_TARGETS")
      list(APPEND nav_components_LIBRARIES nav_targets)
    elseif(component STREQUAL "NAV_ALARMS")
      list(APPEND nav_components_LIBRARIES nav_alarms)
    elseif(component STREQUAL "NAV_NETWORK")
      list(APPEND nav_components_LIBRARIES nav_network)
    else()
      message(FATAL "Invalid component ${component} entered. Possible values are: nav_kernel nav_targets nav_alarms nav_network")
    endif()
  endforeach()
else()
  message(FATAL " No COMPONENTS keyword defined in find_package call!")
endif()

list(APPEND nav_components_LIBRARIES
     ${dynamic_objects_LIBRARIES}
     ${Boost_LIBRARIES}
     nav_common_static
     nav_nmea_static
     geo_calc_static
     ${NAVIMATH_LIB})

if(NOT UNINAV_USE_SIMPLIFIED_LOGGING)
    list(APPEND nav_components_LIBRARIES boost_log)
endif()

set(nav_components_FOUND YES)
set(nav_components_INCLUDE_DIRS
    ${CMAKE_CURRENT_BINARY_DIR}
    ${Boost_INCLUDE_DIRS}
    ${CMAKE_CURRENT_BINARY_DIR}/gen-cpp/
    ${CMAKE_SOURCE_DIR}/private/nav_math/geo_calc)

mark_as_advanced(nav_components_INCLUDE_DIRS nav_components_LIBRARIES)
