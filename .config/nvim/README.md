# Neovim Configuration (_zero plugins_)

This is my Neovim configuration. I'm a minimalist, and hence I've written all the configurations _from scratch without any plugins._

## Features

1. Full LSP Support for:
   1. Python (with Ruff and Pyright)
   2. Go
   3. Support for Formatting HTML/CSS/JS/Markdown with Prettier
2. Easy Keyboard Bindings
3. Netrw and FZF Support

## Key-mappings

| Mode | Key           | Description                                              |
| ---- | ------------- | -------------------------------------------------------- |
| n    | `<leader>en`  | Open netrw file explorer.                                |
| n    | `<leader>ef`  | Launch FZF file search.                                  |
| n    | `<leader>r`   | Open a global substitution prompt (doubles down as document-level symbol replace). |
| n    | `<Tab>`       | Switch to the next buffer.                               |
| n    | `<S-Tab>`     | Switch to the previous buffer.                           |
| n    | `<leader>t`   | Open a new tab.                                          |
| n    | `<leader>td`  | Close the current tab.                                   |
| n    | `<leader>tp`  | Go to the previous tab.                                  |
| n    | `<leader>tn`  | Go to the next tab.                                      |
| n    | `<leader>h`   | Create a horizontal split.                               |
| n    | `<leader>v`   | Create a vertical split.                                 |
| n    | `<C-h>`       | Move focus to the left window.                           |
| n    | `<C-l>`       | Move focus to the right window.                          |
| n    | `<C-j>`       | Move focus to the window below.                          |
| n    | `<C-k>`       | Move focus to the window above.                          |
| n    | `<leader>qc`  | Close the quickfix list.                                 |
| n    | `<leader>lc`  | Close the location list.                                 |
| n    | `[d`          | Jump to the previous diagnostic.                         |
| n    | `]d`          | Jump to the next diagnostic.                             |
| n    | `<leader>[q`  | Jump to the previous item in the quickfix list.          |
| n    | `<leader>]q`  | Jump to the next item in the quickfix list.              |
| n    | `<leader>[l`  | Jump to the previous item in the location list.          |
| n    | `<leader>]l`  | Jump to the next item in the location list.              |
| n    | `<leader>dl`  | Add diagnostics to the location list.                    |
| n    | `<leader>fl`  | Format the current buffer using LSP.                     |
| n    | `gd`          | Go to the definition.                                    |
| n    | `gD`          | Go to the declaration.                                   |
| n    | `go`          | Go to the type definition.                               |
| n    | `gO`          | List all document symbols.                               |
| n    | `grr`         | Show references within document.                         |
| n    | `grn`         | Rename the symbol under the cursor at **workspace** level. |
| n    | `gi`          | Go to the implementation.                                |
| n    | `gS`          | Search for symbols in the workspace.                     |
| n    | `K`           | Show information for the symbol in a popup.              |
| n    | `<leader>fp`  | Format using Prettier.                                   |

---

## User Commands

### Global Commands

| Command       | Description                                  |
| ------------- | -------------------------------------------- |
| `:ApacheX692` | Display the Apache X692 ASCII splash screen. |

### LSP Commands

| Command                                   | Description                                     |
| ----------------------------------------- | ----------------------------------------------- |
| `:LspCapabilities`                        | List all capabilities of active LSP servers.    |
| `:LspInfo`                                | Show health information for LSP.                |
| `:LspEnable {lsp_name}`                   | Enable an LSP client by its name if configured. |
| `:PythonPyrightSetInterpreterPath {path}` | Set the interpreter path for Pyright.           |
| `:MarkdownShowToC`                        | Show the table of contents for Markdown.        |

---

## Auto-Commands

### Global Auto-commands

| Trigger    | Pattern(s)                   | Effect                                          |
| ---------- | ---------------------------- | ----------------------------------------------- |
| `FileType` | `yaml`, `lua`, `html`, `hcl` | Set indentation width to 2 spaces.              |
| `FileType` | `go`                         | Set indentation width to 4 spaces and use tabs. |

### LSP Auto-commands

| Trigger     | Pattern     | Effect                                    |
| ----------- | ----------- | ----------------------------------------- |
| `LspAttach` | All buffers | Invoke the autocomplete helper on attach. |

---

## Mouse

I don't use the mouch much (apparent), except for resizing windows. Drag the borders to resize.

This configuration offers a productive foundation for daily usage and development across languages.

## Important

There are some weird things that I want you to remember when working with this configuration:
1. The `PythonPyrightSetInterpreterPath {path}` works only when you have at least one buffer opened and attached to the LSP. Please do not invoke it without this as it'll not work.
