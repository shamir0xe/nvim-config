return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map

          -- navigate buffer tabs with `H` and `L`
          -- L = {
          --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          --   desc = "Next buffer",
          -- },
          -- H = {
          --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          --   desc = "Previous buffer",
          -- },

          -- mappings seen under group name "Buffer"
          ["<Leader>bD"] = {
            function()
              require("astronvim.utils.status").heirline.buffer_picker(
                function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          ["<Leader>bb"] = {
            function() require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = false } end,
            -- "<cmd>lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })<cr>",
            desc = "Find buffers",
          },
          ["<Leader>bf"] = { "<cmd>only<cr>", desc = "Focus on this buffer" },
          ["<Leader>b%"] = { "<cmd>vsplit<cr>", desc = "split the buffer to right" },
          ['<Leader>b"'] = { "<cmd>split<cr>", desc = "split the buffer to bot" },
          -- close the current buffer
          ["<Leader>x"] = { "<cmd>bd<cr>", desc = "Close buffer" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
          ["<Leader>a"] = { name = "🐒 Scripts" },
          ["<Leader>ap"] = { "<cmd>PyrightSetPythonPath ./venv/bin/python3<cr>", desc = "🐍 Set Pyright env path" },
          -- format the current buffer
          ["<Leader>F"] = {
            function()
              vim.cmd ":Format"
              -- vim.api.nvim_buf_create_user_command(
              --   bufnr,
              --   "Format",
              --   function() vim.lsp.buf.format(M.format_opts) end,
              --   { desc = "Format file with LSP" }
              -- )
              -- if vim.bo.filetype == "js" or vim.bo.filetype == "javascript" then
              --   require("null-ls").builtins. {
              --     bufnr = vim.lsp.buf.bufnr,
              --     format_on_save = { enabled = false },
              --   }
              -- else
              --
              -- require("vim.lsp").buf.format(M.format_opts)
              -- vim.lsp.buf.format {
              --
              --   -- filter = function(client) return client.name == "null-ls" end,
              --   bufnr = vim.lsp.buf.bufnr,
              --   format_on_save = { enabled = false },
              --   disabled = {},
              -- }
              -- end
            end,
            desc = "Format buffer",
          },
          ["<Leader><Tab>"] = { "<cmd>b#<cr>", desc = "Previous buffer" },
          ["<Leader>;"] = {
            function()
              if vim.bo.filetype == "text" then
                -- for text files do checkbox toggle
                vim.cmd ":ChecklistToggleCheckbox"
              else
                require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
              end
            end,
            desc = "Toggle comment line",
          },

          -- Navigate buffers
          ["<Tab>"] = { "<cmd>bnext<cr>" },
          ["<S-l>"] = { "<cmd>bnext<cr>" },
          ["<S-h>"] = { "<cmd>bprevious<cr>" },

          -- Move text up and down
          -- ["<A-j>"] = { "<cmd>m .+1<CR>==" },
          -- ["<A-k>"] = { "<cmd>m .-2<CR>==" },
          --
          -- hit enter to put blank line
          ["<Enter>"] = { "o<ESC>" },
          ["<S-Enter>"] = { "O<ESC>" },
          -- for the checklist plugin
          ["<Leader>c"] = { "<cmd>ChecklistToggleCheckbox<cr>", desc = "Toggle" },

          -- ZenMode
          ["<Leader>z"] = { function() require("zen-mode").toggle() end, desc = "Toggle ZenMode" },

          --lsp_signature
          -- ["<C-j>"] = {
          --   function() require("lsp_signature").toggle_float_win() end,
          --   desc = "toggle signature",
          --   noremap = true,
          --   silent = true,
          -- },
        },
        i = {
          -- ["<C-Enter>"] = {
          --   function() require("lsp_signature").toggle_float_win() end,
          --   { silent = true, noremap = true, desc = "toggle signature" },
          -- },
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
        v = {
          -- for the checklist plugin
          -- ["<Leader>ct"] = { "<cmd>ChecklistToggleCheckbox<cr>", desc = "Toggle" },
          -- ["<Leader>ce"] = { "<cmd>ChecklistEnableCheckbox<cr>", desc = "Enable" },
          -- ["<Leader>cd"] = { "<cmd>ChecklistDisableCheckbox<cr>", desc = "Disable" },
          -- Stay in indent mode
          ["<"] = { "<gv^" },
          [">"] = { ">gv^" },

          -- No stupid paste after yanking
          ["p"] = { '"_dP' },
          -- Move text up and down
          -- ["<A-j>"] = {"<cmd>m '>+1<CR>gv=gv", opts)
          -- keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
          -- keymap("v", "p", '"_dP', opts)
          ["<Leader>;"] = {
            "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
            desc = "Toggle comment for selection",
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
