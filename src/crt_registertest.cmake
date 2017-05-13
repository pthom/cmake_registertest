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

function (crt_maketesttarget flagTestInPlace libraryName testTargetName testSources)
  if (flagTestInPlace)
    add_executable(${testTargetName} $<TARGET_OBJECTS:${libraryName}> ${testSources} ${crt_main_test_file})
  else()
    add_executable(${testTargetName} ${testSources} ${crt_main_test_file})
    target_link_libraries(${testTargetName} ${libraryName})
  endif()
  crt_placetarget_insamesolutionfolder(${testTargetName} ${libraryName})
  target_link_libraries(${testTargetName} ${crt_main_test_link})
  crt_addincludepath(${testTargetName})

  add_test(NAME ${crt_OUTPUT_TEST_TARGET} COMMAND ${crt_OUTPUT_TEST_TARGET})
endfunction()

function (crt_registertest)
  set(options 
    TEST_INPLACE
  )
  set(one_value_args
    LIBRARY
    INPUT_OBJECT_LIBRARY
    OUTPUT_LIBRARY_NAME
    OUTPUT_LIBRARY_TYPE
    OUTPUT_TEST_TARGET
    )
  set(multi_value_args
    TEST_SOURCES
  )
  
  cmake_parse_arguments(crt "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})
  
  if (crt_TEST_INPLACE)
    if (NOT crt_INPUT_OBJECT_LIBRARY)
      message( FATAL_ERROR "crt_registertest : the INPUT_OBJECT_LIBRARY param is required if using TEST_INPLACE")
    endif()
    if (NOT crt_OUTPUT_LIBRARY_NAME)
      message( FATAL_ERROR "crt_registertest : the OUTPUT_LIBRARY_NAME param is required if using TEST_INPLACE")
    endif()
    if (crt_LIBRARY)
      message( FATAL_ERROR "crt_registertest : the LIBRARY param is incompatible with the option TEST_INPLACE")
    endif()
    crt_addincludepath(${crt_INPUT_OBJECT_LIBRARY})
    if (${crt_OUTPUT_LIBRARY_TYPE} MATCHES "STATIC")
      add_library(${crt_OUTPUT_LIBRARY_NAME} ${crt_OUTPUT_LIBRARY_TYPE} $<TARGET_OBJECTS:${crt_INPUT_OBJECT_LIBRARY}>)
    else()
      add_library(${crt_OUTPUT_LIBRARY_NAME} ${crt_OUTPUT_LIBRARY_TYPE} $<TARGET_OBJECTS:${crt_INPUT_OBJECT_LIBRARY}> ${crt_dynamic_test_file})
      target_link_libraries(${crt_OUTPUT_LIBRARY_NAME} ${crt_dynamic_test_link})
    endif()
    crt_placetarget_insamesolutionfolder(${crt_OUTPUT_LIBRARY_NAME} ${crt_INPUT_OBJECT_LIBRARY})
    crt_addincludepath(${crt_OUTPUT_LIBRARY_NAME})
    crt_maketesttarget(TRUE ${crt_INPUT_OBJECT_LIBRARY} ${crt_OUTPUT_TEST_TARGET} "${crt_TEST_SOURCES}")
  else()
    message( "crt_LIBRARY is ${crt_LIBRARY}")
    if (NOT crt_LIBRARY)
      message( FATAL_ERROR "crt_registertest : the LIBRARY param is required if not using TEST_INPLACE")
    endif()
    crt_maketesttarget(FALSE ${crt_LIBRARY} ${crt_OUTPUT_TEST_TARGET} "${crt_TEST_SOURCES}")
  endif()

endfunction()
