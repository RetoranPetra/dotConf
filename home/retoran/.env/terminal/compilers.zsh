#!/bin/zsh
export CMAKE_BUILD_PARALLEL_LEVEL=24
# use cache for building with rust
export RUSTC_WRAPPER=sccache
