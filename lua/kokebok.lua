local function RunShellInPopup(command)
  -- 1. Create a new scratch buffer for the output
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value('buflisted', false, { buf = buf })
  vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })

  -- 2. Define the floating window options
  local width = vim.api.nvim_win_get_width(0) * 0.8
  local height = vim.api.nvim_win_get_height(0) * 0.5
  local row = (vim.api.nvim_win_get_height(0) - height) / 2
  local col = (vim.api.nvim_win_get_width(0) - width) / 2
  local opts = {
    relative = 'editor',
    width = math.floor(width),
    height = math.floor(height),
    row = math.floor(row),
    col = math.floor(col),
    anchor = 'NW',
    style = 'minimal',
    border = 'single', -- Adds a border
  }

  -- 3. Open the floating window
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_set_option_value('wrap', false, { win = win })

  -- 4. Define callback function to write output to the buffer
  local function append_lines(_, data)
    if not data or #data == 0 then
      return
    end
    -- jobstart sends a trailing empty string; avoid adding it.
    if #data == 1 and data[1] == '' then
      return
    end
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(buf), 0 })
    end
  end

  vim.keymap.set('n', 'q', function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, silent = true })

  -- 5. Start the job
  vim.fn.jobstart(command, {
    on_stdout = append_lines,
    on_stderr = append_lines,
    stdout_buffered = false,
    stderr_buffered = false,
    on_exit = function()
      vim.defer_fn(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end, 200)
    end,
  })
end

vim.keymap.set('n', '<leader>kd', function()
  RunShellInPopup { 'bash', '-c', 'cd /Users/simen/Dropbox/prosjekter/simens_kokebok && npm run deploy' }
end, { desc = '[K]okebok [D]eploy' })
