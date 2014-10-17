####
#### Generic Makefile for C or C++ projects
####
#### Features:
#### - Build an application, static library or shared library
#### - Include source files from multiple subdirectories
####
#### This file is public domain. See end of file for license.
#### Jamie Bullock 2014 <jamie@jamiebullock.com>
####

###################################
### User configurable variables ###
###################################

#### Do not modify this file
#### Instead override these variables in a separate Make.config file if needed

# The name of the product to build (default uses parent directory name)
NAME = $(notdir $(CURDIR))
# The file suffix of source files, can be .c or .cpp
SUFFIX = .cpp
# List of directories containing source files to be compiled
DIRS = .
# Flags to pass to the compiler for release builds
FLAGS = -O3
# Flags to pass to the compiler for debug builds
DEBUG_FLAGS = -O0 -g
# Flags to pass to the linker
LDFLAGS =
# Type of product to build: "shared" for a shared library, "static" for a static library, empty for standalone
LIBRARY = static

##############################################
### Do not modify anything below this line ###
##############################################

-include Make.config

OUT_DIR = .build
SRC := $(foreach dir, $(DIRS), $(wildcard $(dir)/*$(SUFFIX)))
OBJ_ = $(SRC:$(SUFFIX)=.o)
OBJ=$(addprefix $(OUT_DIR)/,$(OBJ_))
DEPS=$(OBJ:.o=.d)
SHARED_SUFFIX = dll
STATIC_SUFFIX = lib

ifeq ($(OS),Windows_NT)
else
    PLATFORM := $(shell uname -s)
endif

ifeq "$(PLATFORM)" "Darwin"
    SHARED_SUFFIX = dylib
    STATIC_SUFFIX = a
endif

ifeq "$(PLATFORM)" "Linux"
    SHARED_SUFFIX = so
    STATIC_SUFFIX = a
endif

ifeq "$(LIBRARY)" "shared"
    OUT=lib$(NAME).$(SHARED_SUFFIX)
    LDFLAGS += -shared
else ifeq "$(LIBRARY)" "static"
    OUT=lib$(NAME).$(STATIC_SUFFIX)
else
    OUT=$(NAME)
endif

ifeq "$(SUFFIX)" ".cpp"
    CXX = g++
else ifeq "$(SUFFIX)" ".c"
    CXX = gcc
endif

.SUFFIXES:
.PHONY: debug clean

$(OUT): $(OBJ)
ifeq "$(LIBRARY)" "static"
	$(AR) rcs $@ $^
else
	$(CXX) $(LDFLAGS) $^ -o $@
endif

debug: FLAGS = $(DEBUG_FLAGS)
debug: $(OUT)

$(OUT_DIR)/%.o: %$(SUFFIX)
	@mkdir -p $(dir $@)
	$(CXX) $(FLAGS) -MMD -MP -fPIC -c $< -o $@

clean:
	$(RM) -r $(OUT) $(OUT_DIR)

-include $(DEPS)

###############
### License ###
###############

# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

