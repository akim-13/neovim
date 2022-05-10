local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

vim.cmd "hi NormalFloat ctermbg=NONE" -- Make the background of popup window invisible

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "", -- ➜symbol used between a key and it's label
    group = " ", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "single", -- none, single, double, shadow, rounded
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 4, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local optsN = {
  mode = "n", -- NORMAL mode
  prefix = "",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps

}

local optsV = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,

}

local mappingsN = {
	["<LEADER>w"] = { name = "Write" },
	["<LEADER>ww"] = { ":w<CR>", "Write file" },
	["<LEADER>ws"] = { ":w<CR>:source %<CR>", "Write and source file (save nvim config)" },

	["<LEADER>o"] = { "mzo<ESC>`z", "Insert new line below" },
	["<LEADER>O"] = { "mzO<ESC>`z", "Insert new line above" },

	["<LEADER>/"] = { ":set nohlsearch<CR>", "Disable highlight search" },

 	["<LEADER>e"] = { ":NvimTreeToggle<cr>", "File explorer" },

	["z"] = { ":WhichKey z<CR>", "Folds/Spelling/Screen motions" },
	["g"] = { ":WhichKey g<CR>", "Misc" },

	["<LEADER><F5>"] = { 'autocmd FileType python nnoremap <buffer> <leader><F5>\
						 <ESC>:w<CR>:split<CR>:terminal python3.10 "%"<CR>i', "Run code" },

	["<F3>"] = { ":call vimspector#Stop()<CR>", "Stop debugger" },
	["<F4>"] = { ":call vimspector#Restart()<CR>", "Restart debugger" },
	["<F5>"] = { ":call vimspector#Continue()<CR>", "Start/continue debugging" },
	["<F6>"] = { ":call vimspector#Pause()<CR>", "Pause debugger" },
	["<F8>"] = { ":call vimspector#AddFunctionBreakpoint()<CR>", "Add function breakpoint (?) (debug)" },
	["<leader><F8>"] = { ":call vimspector#RunToCursor()<CR>", "Run to cursor (debug)" },
	["<F9>"] = { ":call vimspector#ToggleBreakpoint()<CR>", "Toggle breakpoint (debug)" },
	["<leader><F9>"] = { ":call vimspector#ToggleConditionalBreakpoint()<CR>", "Toggle conditional breakpoint (debug)" },
	["<F10>"] = { ":call vimspector#StepOver()<CR>", "Step over (debug)" },
	["<F11>"] = { ":call vimspector#StepInto()<CR>", "Step into (debug)" },
	["<F12>"] = { ":call vimspector#StepOut()<CR>", "Step out (debug)" },

	["<LEADER>d"] = { name = "Debug" },
 	["<LEADER>dr"] = { ":call vimspector#Reset()<CR>", "Reset (close) the debugger" },

	--[""] = { "", "" },
	--[""] = { "", "" },
	--[""] = { "", "" },
	--[""] = { "", "" },
	--[""] = { "", "" },


--  ["f"] = {
--    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
--    "Find files",
--  },
--  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
--
--  s = {
--    name = "Search",
--    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
--    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
--    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
--    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
--    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--    R = { "<cmd>Telescope registers<cr>", "Registers" },
--    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
--    C = { "<cmd>Telescope commands<cr>", "Commands" },
--  },
}

which_key.setup(setup)
which_key.register(mappingsN, optsN)