-- init.lua (or a file you source)

-- ----------------------------------------------------------------------
--  Helper to get the current window width
local function win_width()
  return vim.api.nvim_win_get_width(0)
end

-- ----------------------------------------------------------------------
--  ASCII art – raw strings, no escaping needed
local art = {
  [[         ,--.                                                        ]],
  [[       ,--.'|                                                 ____   ]],
  [[   ,--,:  : |                                ,--,           ,'  , `. ]],
  [[,`--.'`|  ' :             ,---.            ,--.'|        ,-+-,.' _ | ]],
  [[|   :  :  | |            '   ,'\      .---.|  |,      ,-+-. ;   , || ]],
  [[:   |   \ | :   ,---.   /   /   |   /.  ./|`--'_     ,--.'|'   |  || ]],
  [[|   : '  '; |  /     \ .   ; ,. : .-' . ' |,' ,'|   |   |  ,', |  |, ]],
  [['   ' ;.    ; /    /  |'   | |: :/___/ \: |'  | |   |   | /  | |--'  ]],
  [[|   | | \   |.    ' / |'   | .; :.   \  ' .|  | :   |   : |  | ,     ]],
  [['   : |  ; .''   ;   /||   :    | \   \   ''  : |__ |   : |  |/      ]],
  [[|   | '`--'  '   |  / | \   \  /   \   \   |  | '.'||   | |`-'       ]],
  [['   : |      |   :    |  `----'     \   \ |;  :    ;|   ;/           ]],
  [[;   |.'       \   \  /               '---" |  ,   / '---'            ]],
  [['---'          `----'                       ---`-'                ]],
}

-- ----------------------------------------------------------------------
--  Show the startup screen (centered horizontally)
local function show_startup_screen()
  if vim.fn.argc(-1) ~= 0 then return end   -- only when no file args

  local buf = vim.api.nvim_create_buf(false, true)   -- scratch, unlisted

  -- Make it temporarily modifiable so we can write the lines
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_buf_set_option(buf, "buftype",    "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden",  "wipe")
  vim.api.nvim_buf_set_option(buf, "buflisted",  false)

  -- Pad each line to centre it
  local padded = {}
  local width = win_width()
  for _, line in ipairs(art) do
    local pad = math.max(0, math.floor((width - #line) / 2))
    table.insert(padded, string.rep(" ", pad) .. line)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, padded)

  -- After writing, lock the buffer again
  vim.api.nvim_buf_set_option(buf, "modifiable", false)

  vim.api.nvim_win_set_buf(0, buf)
end

-- ----------------------------------------------------------------------
--  Autocommand
vim.api.nvim_create_autocmd("VimEnter", {
  callback = show_startup_screen,
})
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'auto:1-3'
vim.opt.fillchars = { vert = '│' }
-- Базовые табы
vim.opt.tabstop = 3        -- ширина TAB = 3 пробела
vim.opt.shiftwidth = 3     -- отступы = 3 пробела  
vim.opt.softtabstop = 3    -- софт-табы = 3 пробела
vim.opt.expandtab = true   -- TAB → пробелы

-- Нумерация
vim.opt.number = true
vim.opt.relativenumber = true

-- Разделители и колонки
vim.opt.signcolumn = "auto:1-3"
vim.opt.fillchars = { vert = "│" }
