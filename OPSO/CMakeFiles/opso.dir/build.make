# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ogatayuta/fed/OPSO

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ogatayuta/fed/OPSO

# Include any dependencies generated for this target.
include CMakeFiles/opso.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/opso.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/opso.dir/flags.make

CMakeFiles/opso.dir/main.cpp.o: CMakeFiles/opso.dir/flags.make
CMakeFiles/opso.dir/main.cpp.o: main.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ogatayuta/fed/OPSO/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/opso.dir/main.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/opso.dir/main.cpp.o -c /home/ogatayuta/fed/OPSO/main.cpp

CMakeFiles/opso.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opso.dir/main.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/ogatayuta/fed/OPSO/main.cpp > CMakeFiles/opso.dir/main.cpp.i

CMakeFiles/opso.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opso.dir/main.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/ogatayuta/fed/OPSO/main.cpp -o CMakeFiles/opso.dir/main.cpp.s

CMakeFiles/opso.dir/main.cpp.o.requires:
.PHONY : CMakeFiles/opso.dir/main.cpp.o.requires

CMakeFiles/opso.dir/main.cpp.o.provides: CMakeFiles/opso.dir/main.cpp.o.requires
	$(MAKE) -f CMakeFiles/opso.dir/build.make CMakeFiles/opso.dir/main.cpp.o.provides.build
.PHONY : CMakeFiles/opso.dir/main.cpp.o.provides

CMakeFiles/opso.dir/main.cpp.o.provides.build: CMakeFiles/opso.dir/main.cpp.o

CMakeFiles/opso.dir/opso.cpp.o: CMakeFiles/opso.dir/flags.make
CMakeFiles/opso.dir/opso.cpp.o: opso.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ogatayuta/fed/OPSO/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/opso.dir/opso.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/opso.dir/opso.cpp.o -c /home/ogatayuta/fed/OPSO/opso.cpp

CMakeFiles/opso.dir/opso.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opso.dir/opso.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/ogatayuta/fed/OPSO/opso.cpp > CMakeFiles/opso.dir/opso.cpp.i

CMakeFiles/opso.dir/opso.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opso.dir/opso.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/ogatayuta/fed/OPSO/opso.cpp -o CMakeFiles/opso.dir/opso.cpp.s

CMakeFiles/opso.dir/opso.cpp.o.requires:
.PHONY : CMakeFiles/opso.dir/opso.cpp.o.requires

CMakeFiles/opso.dir/opso.cpp.o.provides: CMakeFiles/opso.dir/opso.cpp.o.requires
	$(MAKE) -f CMakeFiles/opso.dir/build.make CMakeFiles/opso.dir/opso.cpp.o.provides.build
.PHONY : CMakeFiles/opso.dir/opso.cpp.o.provides

CMakeFiles/opso.dir/opso.cpp.o.provides.build: CMakeFiles/opso.dir/opso.cpp.o

# Object files for target opso
opso_OBJECTS = \
"CMakeFiles/opso.dir/main.cpp.o" \
"CMakeFiles/opso.dir/opso.cpp.o"

# External object files for target opso
opso_EXTERNAL_OBJECTS =

opso: CMakeFiles/opso.dir/main.cpp.o
opso: CMakeFiles/opso.dir/opso.cpp.o
opso: CMakeFiles/opso.dir/build.make
opso: CMakeFiles/opso.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable opso"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/opso.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/opso.dir/build: opso
.PHONY : CMakeFiles/opso.dir/build

CMakeFiles/opso.dir/requires: CMakeFiles/opso.dir/main.cpp.o.requires
CMakeFiles/opso.dir/requires: CMakeFiles/opso.dir/opso.cpp.o.requires
.PHONY : CMakeFiles/opso.dir/requires

CMakeFiles/opso.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/opso.dir/cmake_clean.cmake
.PHONY : CMakeFiles/opso.dir/clean

CMakeFiles/opso.dir/depend:
	cd /home/ogatayuta/fed/OPSO && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ogatayuta/fed/OPSO /home/ogatayuta/fed/OPSO /home/ogatayuta/fed/OPSO /home/ogatayuta/fed/OPSO /home/ogatayuta/fed/OPSO/CMakeFiles/opso.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/opso.dir/depend

