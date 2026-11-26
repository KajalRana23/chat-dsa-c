# Contributing

Thanks for your interest in improving this project! It is a learning project,
so clear code and good explanations matter more than clever tricks.

## Getting started
1. Fork the repository and clone your fork.
2. Build and run the demo: `make demo`
3. Create a branch: `git checkout -b feature/my-idea`
4. Make your change, then check it compiles without warnings: `make`
5. Commit with a clear message and open a Pull Request.

## Ideas for contributions
- Red-black tree or B+ tree (linked leaves) as an alternative index
- Fenwick tree for "messages per time bucket" statistics
- Save and load chat history to a file (compressed with the Huffman code)
- Real networking with sockets (`select()` or threads)
- Split `chat_dsa.c` into modules (`hashtable.c`, `trie.c`, `heap.c`, ...)
- Unit tests for each data structure
- Bloom filter for fast "is this username taken?" checks

## Code style
- C99, compiles cleanly with `-Wall -Wextra`
- Comment each data structure with what it is used for and its complexity
- Keep functions short and focused

## Reporting bugs
Open an issue with the command you typed, what you expected, and what happened.
