# Real-Time Chat System in C (Data Structures & Algorithms)

An open-source terminal chat "server" written in C. Every feature is powered
by a classic data structure or algorithm, so the code doubles as a readable
teaching resource. No external libraries, only standard C.

## Features and the DSA behind them

| Feature                      | Data structure / algorithm        | Complexity     |
|------------------------------|-----------------------------------|----------------|
| Login and user lookup        | Hash table (chaining)             | O(1) average   |
| Username autocomplete        | Trie                              | O(prefix)      |
| Delivery order (urgent first)| Max-heap priority queue           | O(log n)       |
| Per-user inbox               | Queue (linked list)               | O(1)           |
| Chat history                 | Doubly linked list                | O(1) delete    |
| Undo / unsend                | Stack                             | O(1)           |
| Messages indexed by time     | **AVL tree** (self-balancing BST) | O(log n)       |
| Messages in a time range     | **AVL range query**               | O(log n + k)   |
| Message lookup by id         | **B-tree** (disk-style index)     | O(log n)       |
| Recent chats                 | **LRU cache** (map + linked list) | O(1)           |
| Group chat rooms             | **Hash table + circular buffer**  | O(1)           |
| Fewest hops between users    | Graph + BFS                       | O(V+E)         |
| Strongest friend connection  | **Dijkstra** with a min-heap      | O(E log V)     |
| Friend communities           | **Union-Find** (rank + compression)| O(alpha(n))   |
| Banned-word filter           | **Aho-Corasick** automaton        | O(n + matches) |
| History compression stats    | **Huffman coding**                | O(n log n)     |
| Keyword search               | KMP string matching               | O(n+m)         |
| Activity leaderboard         | Merge sort                        | O(n log n)     |

Items in bold are new in v2 / v3.

## Build and run

```bash
make          # build
make run      # start interactive chat
make demo     # run the automatic walkthrough
```

Or without make: `gcc -Wall -Wextra -std=c99 -o chat chat_dsa.c && ./chat`

Works on Linux, macOS and Windows (MinGW / WSL).

## Commands

```
Users & graph
  register <name>          create a user          (hash table + trie + union-find)
  login <name>             switch user            (hash lookup)
  users [prefix]           autocomplete usernames (trie)
  friend <name> [1-9]      add friend, 1=closest  (weighted graph)
  path <name>              fewest hops            (BFS)
  bond <name>              strongest connection   (Dijkstra)
  communities              friend groups          (union-find)
  suggest                  people you may know    (graph)

Messaging
  send <name> <text>       send a message         (heap + list + stack + AVL + LRU)
  urgent <name> <text>     urgent message         (heap priority)
  broadcast <text>         message everyone
  process                  deliver queued msgs    (heap -> queues)
  inbox                    read your inbox        (queue)
  open <name>              open a conversation    (LRU cache)
  recent                   recent chats           (LRU cache)
  history [rev]            chat history           (doubly linked list)
  search <keyword>         search history         (KMP)
  undo                     unsend last message    (stack + AVL delete)
  ban <word>               add banned word        (Aho-Corasick)

Rooms
  room create|join <name>  group chat rooms       (hash table)
  room say <name> <text>   post to a room         (circular buffer)
  room log <name>          show last messages
  rooms                    list rooms

Analysis
  avl                      show the AVL tree
  btree                    show the B-tree        (message-id index)
  find <id>                look up a message by id (B-tree search)
  range <t1> <t2>          messages in a time range
  huffman                  compression statistics
  top                      leaderboard            (merge sort)
  tables / ds / demo / help / quit
```

Time `t` is a logical clock that increases by one for every command.

## How a message travels

1. `send` filters banned words (**Aho-Corasick**), then pushes the message into
   the **max-heap** (server queue).
2. It is also appended to the **doubly linked list** (history), inserted into
   the **AVL tree** (time index) and the **B-tree** (id index), pushed on the
   sender's **undo stack**, and the receiver is recorded in the sender's
   **LRU cache**.
3. `process` pops messages from the heap (urgent first, then oldest) and
   enqueues them into each recipient's **inbox queue**.
4. `undo` pops the stack, unlinks the message from the list in O(1) and
   deletes it from the AVL tree (rebalancing) and the B-tree (borrow / merge).

## About the B-tree

The B-tree has minimum degree `t = 2` (`BT_T` in the code), so a node holds
1 to 3 keys and splits and merges are easy to see with just a few messages.
Raise `BT_T` for a wider, shallower tree. `find <id>` reports how many nodes
the search touched, which models disk-page reads. Insert splits full nodes on
the way down; delete covers all the textbook cases (leaf, predecessor,
successor, merge, borrow from a sibling).

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Released under the [MIT License](LICENSE).
