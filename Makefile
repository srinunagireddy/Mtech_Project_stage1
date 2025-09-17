CC := gcc
CFLAGS := -std=c11 -O2 -Wall -Wextra -Werror -pthread
LDFLAGS := -pthread

BUILD_DIR := build
SRC_DIR := src
INC_DIR := include

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

TARGET := mem_ic

.PHONY: all clean run

all: $(BUILD_DIR)/$(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -I$(INC_DIR) -c $< -o $@

$(BUILD_DIR)/$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

run: all
	$(BUILD_DIR)/$(TARGET)

clean:
	rm -rf $(BUILD_DIR)

