#!/bin/zsh
export CMAKE_BUILD_PARALLEL_LEVEL=24
# use cache for building with rust
export RUSTC_WRAPPER=sccache
export DCMAKE_C_COMPILER_LAUNCHER=sccache
export DCMAKE_CXX_COMPILER_LAUNCHER=sccache
