cmake_minimum_required(VERSION 3.19)
project(qt6 C CXX)

# deps: https://github.com/conan-io/conan-center-index/blob/master/recipes/qt/6.x.x/qtmodules6.0.1.conf

set(QT_VER "6.1.0")

include(ExternalProject)
include(ProcessorCount)
ProcessorCount(N)

find_program(MAKE_EXE NAMES make)
message(STATUS "Make found: ${MAKE_EXE}")
message(STATUS "Number of processors: ${N}")
message(STATUS "Install dir: ${CMAKE_INSTALL_PREFIX}")

ExternalProject_Add(zlib
  URL "http://zlib.net/zlib-1.2.11.tar.gz"
  CONFIGURE_COMMAND <SOURCE_DIR>/configure --static --prefix=<INSTALL_DIR>
  BUILD_COMMAND ${MAKE_EXE} -j${N}
  INSTALL_COMMAND ${MAKE_EXE} install
  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/zlib
)

ExternalProject_Add(openssl
  URL "https://www.openssl.org/source/openssl-1.1.1i.tar.gz"
  CONFIGURE_COMMAND <SOURCE_DIR>/config no-shared --static --with-zlib-include=${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/zlib/include --with-zlib-lib=${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/zlib/lib --prefix=<INSTALL_DIR>
  BUILD_COMMAND ${MAKE_EXE} -j${N}
  INSTALL_COMMAND ${MAKE_EXE} install
  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/openssl
)
add_dependencies(openssl zlib)


ExternalProject_Add(qtbase
  URL "https://download.qt.io/official_releases/qt/6.1/${QT_VER}/submodules/qtbase-everywhere-src-${QT_VER}.tar.xz"
  CMAKE_GENERATOR Ninja
  CMAKE_ARGS
        -Wno-dev
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DQT_FEATURE_opengl=ON
        -DQT_FEATURE_journald=OFF
        -DOPENSSL_USE_STATIC_LIBS=ON
        -DQT_FEATURE_openssl_linked=ON
        -DOPENSSL_ROOT_DIR=${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/openssl
        -DFEATURE_icu=ON
        -DFEATURE_pcre2=ON
        -DFEATURE_system_pcre2=OFF
        -DFEATURE_system_zlib=OFF
        -DFEATURE_harfbuzz=ON
        -DFEATURE_system_harfbuzz=OFF
        -DFEATURE_xcb_xlib=ON
        -DFEATURE_xcb=ON
        # -DFEATURE_libinput=ON
        # -DFEATURE_system_xcb_xinput=OFF
        -DFEATURE_xkbcommon=ON
        -DFEATURE_system_sqlite=OFF
        # -DFEATURE_freetype=ON/OFF
        # -DFEATURE_fontconfig=ON

  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/qt${QT_VER}
)
add_dependencies(qtbase openssl)

ExternalProject_Add(qtdeclarative
  URL "https://download.qt.io/official_releases/qt/6.1/${QT_VER}/submodules/qtdeclarative-everywhere-src-${QT_VER}.tar.xz"
  CMAKE_GENERATOR Ninja
  CMAKE_ARGS
        -Wno-dev
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_PREFIX_PATH=<INSTALL_DIR>

  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/qt${QT_VER}
)
add_dependencies(qtdeclarative qtbase)

ExternalProject_Add(qtquickcontrols2
  URL "https://download.qt.io/official_releases/qt/6.1/${QT_VER}/submodules/qtquickcontrols2-everywhere-src-${QT_VER}.tar.xz"
  CMAKE_GENERATOR Ninja
  CMAKE_ARGS
        -Wno-dev
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_PREFIX_PATH=<INSTALL_DIR>

  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/qt${QT_VER}
)
add_dependencies(qtquickcontrols2 qtdeclarative)

ExternalProject_Add(qtnetworkauth
  URL "https://download.qt.io/official_releases/qt/6.1/${QT_VER}/submodules/qtnetworkauth-everywhere-src-${QT_VER}.tar.xz"
  CMAKE_GENERATOR Ninja
  CMAKE_ARGS
        -Wno-dev
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_PREFIX_PATH=<INSTALL_DIR>

  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/qt${QT_VER}
)
add_dependencies(qtnetworkauth qtbase)

ExternalProject_Add(qttools
  URL "https://download.qt.io/official_releases/qt/6.1/${QT_VER}/submodules/qttools-everywhere-src-${QT_VER}.tar.xz"
  CMAKE_GENERATOR Ninja
  CMAKE_ARGS
        -Wno-dev
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        -DCMAKE_PREFIX_PATH=<INSTALL_DIR>

  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/qt${QT_VER}
)
add_dependencies(qttools qtbase)

# ExternalProject_Add(qt5compat
#   URL "https://download.qt.io/official_releases/qt/6.1/${QT_VER}/submodules/qt5compat-everywhere-src-${QT_VER}.tar.xz"
#   CMAKE_GENERATOR Ninja
#   CMAKE_ARGS
#         -Wno-dev
#         -DBUILD_SHARED_LIBS=OFF
#         -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
#         -DCMAKE_PREFIX_PATH=<INSTALL_DIR>

#   INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/qt${QT_VER}
# )
# add_dependencies(qt5compat qtbase)


# ExternalProject_Add(qtcreator
#   URL "https://download.qt.io/official_releases/qtcreator/4.15/4.15.1/qt-creator-opensource-src-4.15.1.tar.xz"
#   CMAKE_GENERATOR Ninja
#   CMAKE_ARGS
#         -Wno-dev
#         -DBUILD_SHARED_LIBS=OFF
#         -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
#         -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/qt${QT_VER}
#         -DOPENSSL_USE_STATIC_LIBS=ON
#         -DOPENSSL_ROOT_DIR=${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/openssl

#   INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/${CMAKE_BUILD_TYPE}/qtcreator_4.15.1
# )

# add_dependencies(qtcreator qt5compat)
