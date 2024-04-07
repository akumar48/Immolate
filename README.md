# Immolate
An OpenCL seed searcher for Balatro.

## Getting Started
Please visit the [Getting Started](docs/getting_started.md) page in the documentation for tips on how to get started. If you are running into issues, please check the [Troubleshooting](docs/troubleshooting.md) page.

## Building and running from scratch

### Windows
Install cmake:
`winget install --id Kitware.CMake`

Install Visual Studio 2022 Build Tools:
`winget install Microsoft.VisualStudio.2022.BuildTools --force --override "--wait --passive --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows11SDK.22000"`

Open the _x64 Native Tools Command Prompt for VS 2022_

Generate required files for building:
`cmake -G "Visual Studio 17 2022" -A x64 -B .\build`

Build:
`cmake --build .\build --config Release`

Run:
`.\build\Release\Immolate.exe`

## Future Plans
- Full support with all features in Balatro 1.0.
- Support for stakes and challenges.
- Saving output to a file.
- A GUI to interact with the searcher without having as much technical knowledge.
