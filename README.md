# gltf-renderer-ser

A standalone version of NVIDIA's GLTF_renderer (an OptiX glTF 2.0 path tracer) from NVIDIA/OptiX_Apps, used as the base for my bachelor thesis at CTU FEE (ČVUT FEL), Prague.

## Requirements

- Windows 10/11 x64 (the only tested platform)
- [CMake](https://cmake.org/download/) 3.31 or newer
- Visual Studio 2022 or 2026 with the Desktop development with C++ workload
- [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) 12.0 or newer (tested with 13.4)
- [OptiX SDK](https://developer.nvidia.com/designworks/optix/download) 7.7 or newer (tested with 9.1.0), installed in its default location
- An NVIDIA RTX GPU with a current driver
- Internet access the first time you configure: fastgltf downloads simdjson then

## Build

```powershell
git clone --recurse-submodules https://github.com/Expleone/gltf-renderer-ser.git
cd gltf-renderer-ser
cmake -S . -B build
cmake --build build --config Release
```
