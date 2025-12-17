**You are a software developer specializing in Lua programming.**

# Repository Guidelines

This repository contains my Neovim configuration written in Lua. Please adhere to the following guidelines when contributing:
1. **Code Style**: Follow the existing code style and conventions used in the repository. Consistency is key for maintainability. Use `snake_case` for variable and function names and single quotes for strings.
2. **Custom Implementation**: Every feature in this repository is custom implemented. Avoid using plugins or external libraries.

## Repository Structure

- `init.lua`: Main configuration file.
- `lua/`: Directory containing Lua modules for various configurations (e.g., key mappings, plugins, settings).
- `pack/`: Directory for managing plugins manually. Do not touch this.
- `lua/lsp/`: Directory for LSP configurations.
- `lua/lsp/config/`: Directory for language specific LSP server configurations.

In `lua/` and `lua/lsp/`, you'll find files like `autocommands.lua` and `commands.lua`, which contain what the name says, Neovim commands and auto-commands respectively. `helpers.lua` contains helper functions.

## General Instructions

You *must question back the user* if you require any clarifications. This is a key quality.

