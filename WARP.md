# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

Project overview
- Language/tooling: C++17 library built with CMake
- Targets: single library target named "mylib"
- Headers in include/, sources in src/
- Release automation via semantic-release (Node devDependencies only for release tooling)

Common commands
- Configure Debug build
  - mkdir -p build && cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
- Configure Release build
  - mkdir -p build && cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
- Build
  - cmake --build build -j
- Clean build artifacts
  - rm -rf build

Notes
- This repository builds a library (no executable target). To use it, link the "mylib" target from a consumer application and add include/ to your include path if not using CMake target usage requirements.
- Tests are not present in this repo at the time of writing. If CTest-based tests are added later, they can be run from the build tree with ctest.

Qt Creator usage (macOS and Linux)
- Open CMakeLists.txt directly in Qt Creator. Use identical configurations across macOS and Linux (Debug/Release, generator such as Ninja or Unix Makefiles) to keep parity, per user preference.
- Qt Creator will respect target_include_directories for "mylib" (PUBLIC include/), so headers will be indexed automatically.

High-level architecture and structure
- Build system
  - CMakeLists.txt declares:
    - project(mylib VERSION 1.0.0)
    - C++ standard 17
    - Library target: add_library(mylib src/mylib.cpp include/mylib.h)
    - Public include path: target_include_directories(mylib PUBLIC include)
- Library layout
  - Public API surface under include/
    - include/mylib.h: declares the API (e.g., void hello())
  - Implementation under src/
    - src/mylib.cpp: implements the API (e.g., prints a greeting)
- Consumption
  - When used via CMake, downstream projects should link against mylib; CMake will propagate include/ as a PUBLIC include directory.

Release and versioning
- semantic-release is configured via .releaserc.json with the following plugins:
  - @semantic-release/commit-analyzer
  - @semantic-release/release-notes-generator
  - @semantic-release/changelog (writes CHANGELOG.md)
  - @semantic-release/git (commits CHANGELOG.md)
  - @semantic-release/github (publishes a GitHub release; assets pattern build/*.tar.gz)
- Branch: main
- Commit format: Conventional Commits are expected for automated versioning and release notes.
- Note: If you intend to publish build artifacts to GitHub (build/*.tar.gz), ensure your CI process produces these archives in the build/ directory before the GitHub publish step runs.

Existing docs and rules discovered
- No README.md, CLAUDE.md, Cursor/Copilot rules, or existing WARP.md were found.

