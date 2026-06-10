CXX = g++
CXXFLAGS = -std=c++14 -O2 -Wall -Wextra -Iinclude

SRC = src/benchmark.cpp
TARGET = build/benchmark.exe

.PHONY: all run quick plot clean

all: $(TARGET)

$(TARGET): $(SRC) include/hash_table.hpp include/strategies.hpp include/hash_utils.hpp include/metrics.hpp
	@if not exist build mkdir build
	$(CXX) $(CXXFLAGS) $(SRC) -o $(TARGET)

run: all
	$(TARGET)

quick: all
	$(TARGET) --quick

plot:
	python scripts/plot_results.py

clean:
	@if exist build rmdir /s /q build
