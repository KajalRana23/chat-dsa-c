CC      = gcc
CFLAGS  = -Wall -Wextra -std=c99 -O2
TARGET  = chat

all: $(TARGET)

$(TARGET): chat_dsa.c
	$(CC) $(CFLAGS) -o $@ $<

run: $(TARGET)
	./$(TARGET)

demo: $(TARGET)
	printf 'demo\nquit\n' | ./$(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all run demo clean
