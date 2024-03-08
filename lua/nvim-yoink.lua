local api = vim.api
local buf, win

local yoinks = {}
local window_open = false

local function open_window()
  if window_open then
    return
  end
  window_open = true

  buf = api.nvim_create_buf(false, true)
  local border_buf = api.nvim_create_buf(false, true)

  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  api.nvim_buf_set_option(buf, 'filetype', 'bufferlist')

  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")

  local win_height = math.ceil(height * 0.5 - 4)
  local win_width = math.ceil(width * 0.4)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local border_opts = {
    style = 'minimal',
    relative = 'editor',
    width = win_width + 2,
    height = win_height + 2,
    row = row - 1,
    col = col - 1
  }

  local opts = {
    style = 'minimal',
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  local border_title = ' Yoinks '
  local border_lines = { '╭' .. border_title .. string.rep('─', win_width - string.len(border_title)) .. '╮' }
  local middle_line = '│' .. string.rep(' ', win_width) .. '│'
  for _ = 1, win_height do
    table.insert(border_lines, middle_line)
  end
  table.insert(border_lines, '╰' .. string.rep('─', win_width) .. '╯')
  api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

  local border_win = api.nvim_open_win(border_buf, true, border_opts)
  win = api.nvim_open_win(buf, true, opts)
  api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "' .. border_buf)

  api.nvim_win_set_option(win, 'cursorline', true)
end

local function save_list()
  yoinks = {}

  for _, line in ipairs(api.nvim_buf_get_lines(buf, 0, -1, false)) do
    if line ~= '' then
      table.insert(yoinks, line)
    end
  end
end

local function update()
  api.nvim_buf_set_option(buf, 'modifiable', true)

  api.nvim_buf_set_lines(buf, 0, -1, false, yoinks)
  api.nvim_buf_set_option(buf, 'modifiable', true)
end

local function save()
  local current_mode = vim.api.nvim_get_mode().mode

  if current_mode == 'n' then
    local current_line = api.nvim_get_current_line()
    table.insert(yoinks, current_line)
  end
end

local function close_window()
  if not window_open then
    return
  end
  window_open = false

  save_list()
  api.nvim_win_close(win, true)
end

local function select()
  local current_line = api.nvim_get_current_line()
  vim.fn.setreg('+', current_line)
  vim.fn.setreg('*', current_line)
  close_window()
end

local function move_cursor()
  local new_pos = math.max(4, api.nvim_win_get_cursor(win)[1] - 1)
  api.nvim_win_set_cursor(win, { new_pos, 0 })
end

local function set_mappings()
  local mappings = {
    ['<esc>'] = 'close_window()',
    ['<cr>'] = 'select()',
    yy = 'select()',
  }

  for k, v in pairs(mappings) do
    api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"nvim-yoink".' .. v .. '<cr>', {
      nowait = true, noremap = true, silent = true
    })
  end
end

local function open()
  open_window()
  update()
  set_mappings()
  api.nvim_win_set_cursor(win, { 1, 0 })
end

return {
  open = open,
  update = update,
  save = save,
  select = select,
  move_cursor = move_cursor,
  close_window = close_window,
}
