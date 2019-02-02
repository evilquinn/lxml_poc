include( ExternalProject )

set( URL
  "http://xmlsoft.org/sources/old/libxml2-2.7.1.tar.gz" )
set( SHA256 "636d3f2c08ff69dd96182d49a3c75027d1bfe8e645e5a1d075a51fc9a9065bd9" )
set( INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/libxml2 )
set( INCLUDE_DIR ${INSTALL_DIR}/include )
set( LIB_DIR ${INSTALL_DIR}/lib )

ExternalProject_Add( external_libxml2
        PREFIX libxml2
        URL ${URL}
        URL_HASH SHA256=${SHA256}
        BUILD_IN_SOURCE 1
        INSTALL_DIR ${PREFIX}
        CONFIGURE_COMMAND ./configure --prefix=${INSTALL_DIR}
                                      --without-python
                                      --without-zlib
        BUILD_COMMAND make
        BUILD_BYPRODUCTS ${LIB_DIR}/libxml2.a
)

file(MAKE_DIRECTORY ${INCLUDE_DIR})

add_library(libxml2_include INTERFACE IMPORTED GLOBAL)
add_dependencies(libxml2_include external_libxml2)
set_target_properties(libxml2_include PROPERTIES
                      INTERFACE_INCLUDE_DIRECTORIES ${INCLUDE_DIR}
                      INTERFACE_SYSTEM_INCLUDE_DIRECTORIES ${INCLUDE_DIR})

add_library( xml2 STATIC IMPORTED GLOBAL)
set_target_properties( xml2 PROPERTIES
    IMPORTED_LOCATION ${LIB_DIR}/libxml2.a )
target_link_libraries( xml2 INTERFACE libxml2_include )
