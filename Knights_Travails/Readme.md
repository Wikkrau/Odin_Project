# Knight's Travails

A Ruby implementation that finds the shortest path for a chess knight to move from one square to another on a standard 8x8 chessboard using breadth-first search (BFS) algorithm.

## Overview

This project solves the classic "Knight's Travails" problem by implementing a BFS algorithm with an object-oriented approach. The knight can move in the traditional L-shaped pattern, and the program finds the minimum number of moves required to reach the target position.

## Features

- **Shortest Path Finding**: Uses BFS to guarantee the minimum number of moves
- **Chess Notation Display**: Converts array coordinates to standard chess notation (a1-h8)
- **Object-Oriented Design**: Knight nodes with parent tracking for efficient path reconstruction
- **Visual Path Display**: Shows the complete path from start to destination

## How It Works

### Knight Movement Pattern
The knight moves in an L-shape: 2 squares in one direction and 1 square perpendicular, resulting in 8 possible moves:
```
[2, 1], [1, 2], [-1, 2], [-2, 1],
[-2, -1], [-1, -2], [1, -2], [2, -1]
```

### Algorithm
1. **BFS Traversal**: Explores all possible positions level by level
2. **Parent Tracking**: Each knight node stores its parent for path reconstruction
3. **Visited Set**: Prevents revisiting the same square
4. **Path Reconstruction**: Traces back from target to start using parent pointers

## Coordinate System

The program uses a 0-indexed array system internally:
- `[0, 0]` represents square **a1**
- `[7, 7]` represents square **h8**
- Array format: `[row, column]`

### Chess Notation Conversion
- **Columns**: 0='a', 1='b', ..., 7='h'
- **Rows**: 0='1', 1='2', ..., 7='8'
