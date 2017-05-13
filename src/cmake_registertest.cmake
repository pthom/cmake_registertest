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


function (crt_addincludepath libraryName)
  target_include_directories(${libraryName} PUBLIC ${crt_test_lib_location} )
endfunction()


# function (crt_appendregistermainfiletosources libraryName)
#   get_target_property(sources ${libraryName} SOURCES)

#   # append crt_registerstaticlibrary.cpp to the library sources if needed
#   if (NOT ";${SOURCES};" MATCHES ";crt_registerstaticlibrary.cpp;")
#     set(sourcesWithMainRegisterFile ${SOURCES} crt_registerstaticlibrary.cpp)
#     target_sources(${libraryName} PRIVATE ${sourcesWithMainRegisterFile})
#   endif()
# endfunction()

function (crt_maketesttarget libraryName testTargetName)
  add_executable(${testTargetName} ${crt_main_test_file})
  target_link_libraries(${testTargetName} ${libraryName})

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


function (cmake_registertest libraryName testTargetName)
  # message("cmake_registertest " ${libraryName} ${testTargetName})
  crt_addincludepath(${libraryName})
  # crt_appendregistermainfiletosources(${libraryName})
  # crt_maketesttarget(${libraryName} ${testTargetName})
  # crt_registercmaketest(${testTargetName})
endfunction()
