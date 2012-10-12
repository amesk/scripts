if (dynamic_objects_INCLUDE_DIRS AND dynamic_objects_LIBRARIES)
  # Already in cache, be silent
  set(dynamic_objects_FIND_QUIETLY TRUE)
endif (dynamic_objects_INCLUDE_DIRS AND dynamic_objects_LIBRARIES)

if(dynamic_objects_FIND_COMPONENTS)
  foreach(component ${dynamic_objects_FIND_COMPONENTS})
    string(TOUPPER ${component} component)
    if(component STREQUAL "DYNOBJ")
      list(APPEND dynamic_objects_LIBRARIES
        dynamic_objects_static
        nav_common_static
        dom_config
        tinyxpath
        tinyxml)
    endif()
    if(component STREQUAL "XXX")
      list(APPEND dynamic_objects_LIBRARIES xxx)
    endif()
  endforeach()
else()
  set(dynamic_objects_LIBRARIES
      dynamic_objects_static
      nav_common_static
      dom_config
      tinyxpath
      tinyxml)
endif()

set(dynamic_objects_FOUND YES)
set(dynamic_objects_INCLUDE_DIRS ${})

mark_as_advanced(dynamic_objects_INCLUDE_DIRS dynamic_objects_LIBRARIES)
