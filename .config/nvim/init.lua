-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

local keymap = vim.api.nvim_set_keymap

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use {'ray-x/lsp_signature.nvim'}
  use 'hrsh7th/nvim-compe' -- Autocompletion plugin
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use {'rust-lang/rust.vim'}
  use 'simrat39/rust-tools.nvim'

  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-surround'
  use 'alaviss/nim.nvim'

  use 'ianding1/leetcode.vim'
  use 'google/vim-maktaba'
  use 'bazelbuild/vim-bazel' 
  use {'vim-scripts/a.vim',}
  use 'mfussenegger/nvim-dap'
end)

--Incremental live completion
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

vim.o.tabstop=4     
vim.o.softtabstop=4 
vim.o.shiftwidth=4  
vim.o.expandtab=true
vim.o.autoindent=true
vim.o.copyindent=true

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd [[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme onedark]]

--Set statusbar
vim.g.lightline = {
  colorscheme = 'onedark',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

--Remap space as leader key
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- LSP settings
local nvim_lsp = require 'lspconfig'

local key_mappings = {
    {'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>'},
    {'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>'},
    {'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>'},
    {'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>'},
    {'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>'},
    {'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'},
    {'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'},
    {'n', '<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>'},
    {'n', '<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>'},
    {
        'n', '<leader>llw',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'
    }, {'n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>'},
    {'n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>'},
    {'n', '<leader>lrf', '<cmd>lua vim.lsp.buf.references()<CR>'},
    {
        'n', '<leader>lds',
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'
    }, {'n', '<leader>lde', '<cmd>lua vim.lsp.diagnostic.enable()<CR>'},
    {'n', '<leader>ldd', '<cmd>lua vim.lsp.diagnostic.disable()<CR>'},
    {'n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>'},
    {'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>'},
    {'v', '<leader>lcr', '<cmd>lua vim.lsp.buf.range_code_action()<CR>'},
    {'n', '<leader>lss', '<cmd>lua vim.lsp.buf.document_symbol()<CR>'},
    {'n', '<leader>lsw', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>'}
}

local alt_key_mappings = {
    {
        "document_formatting", "n", "<leader>lf",
        "<cmd>lua vim.lsp.buf.formatting()<CR>"
    }, {
        "document_range_formatting", "n", "<leader>lf",
        "<cmd>lua vim.lsp.buf.range_formatting()<CR>"
    },
    {
        "code_lens", "n", "<leader>lcld",
        "<Cmd>lua vim.lsp.codelens.refresh()<CR>"
    }, {"code_lens", "n", "<leader>lclr", "<Cmd>lua vim.lsp.codelens.run()<CR>"}
}

local function set_lsp_config(client, bufnr)
    require"lsp_signature".on_attach({
        bind = true,
        handler_opts = {border = "single"}
    })

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(...) end

    buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Key mappings
    local opts = {noremap = true, silent = true}
    for _, mappings in pairs(key_mappings) do
        local mode, lhs, rhs = unpack(mappings)
        buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Other key mappings
    for _, mappings in pairs(alt_key_mappings) do
        local capability, mode, lhs, rhs = unpack(mappings)
        if client.resolved_capabilities[capability] then
            buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end
    end

end


local on_attach = function(client, bufnr)
    set_lsp_config(client, bufnr)

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"}
}
capabilities.experimental = {}
capabilities.experimental.hoverActions = true

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'nimls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- set up rust tools
local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = { use_telescope = true },
        inlay_hints = {show_parameter_hints = true},
    },
    server = {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {debounce_text_changes = 150}
    } -- rust-analyer options
}

require('rust-tools').setup(opts)

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Compe setup
require('compe').setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = false,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}

-- Utility functions for compe and luasnip
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local luasnip = require 'luasnip'

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

-- Map tab to the above tab complete functiones
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })


-- Window movement
keymap('n', "<leader>wj", '<Cmd>wincmd j<CR>', {noremap=true});
keymap('n', "<leader>wk", '<Cmd>wincmd k<CR>', {noremap=true});
keymap('n', "<leader>wl", '<Cmd>wincmd l<CR>', {noremap=true});
keymap('n', "<leader>wh", '<Cmd>wincmd h<CR>', {noremap=true});
keymap('n', "<leader>wm", '<Cmd>only<CR>', {noremap=true});

vim.g.leetcode_browser = 'firefox'
