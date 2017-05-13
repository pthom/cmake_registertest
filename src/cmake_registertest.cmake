# Cmake register tests :
# Helper functions in order to activate and register tests
# using catch, doctest or google test

# crt_ is used as a prefix for most functions, in order to not pollute
# the main namespace

if(NOT DEFINED crt_test_lib_location)
  message("")
  message("Please define crt_test_lib_location with the location of the folder containing your test lib (for example the folder containing catch.hpp)")
  message("For example:")
  message("set (crt_test_lib_location ${CMAKE_SOURCE_DIR}/catch)")
  message("")
  message(FATAL_ERROR "Please define crt_test_lib_location)")
endif()

set (crt_location ${CMAKE_CURRENT_LIST_DIR})

if (MSVC)
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()

# place the test targets in the same msvc solution folder
function (crt_placetarget_insamesolutionfolder target target_with_existing_folder)
  get_target_property(msvc_folder_target ${target} FOLDER)
  message("msvc_folder_target is ${msvc_folder_target}")
  if (${msvc_folder_target} MATCHES ".*NOTFOUND")
    message("get_target_property(msvc_folder ${target_with_existing_folder} FOLDER)")
    get_target_property(msvc_folder "${target_with_existing_folder}" FOLDER)
    message("msvc_folder is ${msvc_folder}")
    if (NOT ${msvc_folder} MATCHES ".*NOTFOUND")
      set_target_properties(${target} PROPERTIES FOLDER ${msvc_folder})
    endif()
  endif()
endfunction()


function (crt_addincludepath libraryName)
  target_include_directories(${libraryName} PUBLIC ${crt_test_lib_location} )
endfunction()

function (crt_maketesttarget objectLibraryName testTargetName testSources)
  add_executable(${testTargetName} $<TARGET_OBJECTS:${objectLibraryName}> ${testSources} ${crt_main_test_file})
  crt_placetarget_insamesolutionfolder(${testTargetName} ${objectLibraryName})
  target_link_libraries(${testTargetName} ${crt_main_test_link})
  crt_addincludepath(${testTargetName})
  # place the test target in the same msvc solution folder
  get_target_property(msvc_folder_testtarget ${testTargetName} FOLDER)
  if (${msvc_folder_testtarget} MATCHES ".*NOTFOUND")
    get_target_property(msvc_folder ${libraryName} FOLDER)
    if (NOT ${msvc_folder} MATCHES ".*NOTFOUND")
      set_target_properties(${testTargetName} PROPERTIES FOLDER ${msvc_folder})
    endif()
  endif()
endfunction()

function (crt_registercmaketest testTargetName)
  add_test(NAME ${testTargetName} COMMAND ${testTargetName})
endfunction()

function (cmake_registertest)
  set(options 
    INSOURCE_TEST
  )
  set(one_value_args
    INPUT_OBJECT_LIBRARY
    OUTPUT_LIBRARY_NAME
    OUTPUT_LIBRARY_TYPE
    OUTPUT_TEST_TARGET
    )
  set(multi_value_args
    TEST_SOURCES
  )
  
  cmake_parse_arguments(crt "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN} )
  
  message("cmake_registertest " ${crt_OUTPUT_LIBRARY_NAME} ${crt_OUTPUT_TEST_TARGET})
  crt_addincludepath(${crt_INPUT_OBJECT_LIBRARY})
  if (${crt_OUTPUT_LIBRARY_TYPE} MATCHES "STATIC")
    add_library(${crt_OUTPUT_LIBRARY_NAME} ${crt_OUTPUT_LIBRARY_TYPE} $<TARGET_OBJECTS:${crt_INPUT_OBJECT_LIBRARY}>)
  else()
    add_library(${crt_OUTPUT_LIBRARY_NAME} ${crt_OUTPUT_LIBRARY_TYPE} $<TARGET_OBJECTS:${crt_INPUT_OBJECT_LIBRARY}> ${crt_dynamic_test_file})
    target_link_libraries(${crt_OUTPUT_LIBRARY_NAME} ${crt_dynamic_test_link})
  endif()
  crt_placetarget_insamesolutionfolder(${crt_OUTPUT_LIBRARY_NAME} ${crt_INPUT_OBJECT_LIBRARY})
  crt_addincludepath(${crt_OUTPUT_LIBRARY_NAME})
  crt_maketesttarget(${crt_INPUT_OBJECT_LIBRARY} ${crt_OUTPUT_TEST_TARGET} "${crt_TEST_SOURCES}")
  crt_registercmaketest(${crt_OUTPUT_TEST_TARGET})
endfunction()
