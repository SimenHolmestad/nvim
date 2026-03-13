return {
  {
    'preservim/vim-markdown',
    ft = { 'markdown' },
    init = function()
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_no_extensions_in_markdown = 1
      vim.g.vim_markdown_follow_anchor = 1
    end,
    config = function()
      local function heading_level(line)
        local hashes = line:match '^(#+)%s+'
        return hashes and #hashes or nil
      end

      function _G.markdown_heading_foldexpr(lnum)
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local line = lines[lnum] or ''
        local level = heading_level(line)
        if level then
          return math.max(level - 1, 0)
        end

        for line_nr = lnum - 1, 1, -1 do
          local parent_level = heading_level(lines[line_nr])
          if parent_level then
            return parent_level
          end
        end

        return 0
      end

      local function current_heading_range(bufnr)
        local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        local start_line
        local level
        for line_nr = cursor_line, 1, -1 do
          level = heading_level(lines[line_nr])
          if level then
            start_line = line_nr
            break
          end
        end

        if not start_line or not level then
          return nil
        end

        local end_line = #lines
        for line_nr = start_line + 1, #lines do
          local next_level = heading_level(lines[line_nr])
          if next_level and next_level <= level then
            end_line = line_nr - 1
            break
          end
        end

        return {
          start_line = start_line,
          end_line = end_line,
          level = level,
          lines = lines,
        }
      end

      local function sibling_heading_start(range, direction)
        local step = direction == 'up' and -1 or 1
        local line_nr = direction == 'up' and range.start_line - 1 or range.end_line + 1

        while line_nr >= 1 and line_nr <= #range.lines do
          local level = heading_level(range.lines[line_nr])
          if level and level < range.level then
            return nil
          end
          if level and level == range.level then
            return line_nr
          end
          line_nr = line_nr + step
        end

        return nil
      end

      local function heading_end_line(lines, start_line, level)
        for line_nr = start_line + 1, #lines do
          local next_level = heading_level(lines[line_nr])
          if next_level and next_level <= level then
            return line_nr - 1
          end
        end

        return #lines
      end

      local function move_heading(direction)
        local bufnr = vim.api.nvim_get_current_buf()
        local range = current_heading_range(bufnr)
        if not range then
          vim.notify('Cursor is not inside a markdown heading', vim.log.levels.WARN)
          return
        end

        local sibling_start = sibling_heading_start(range, direction)
        if not sibling_start then
          vim.notify('No sibling heading to move ' .. direction, vim.log.levels.INFO)
          return
        end

        local sibling_end = heading_end_line(range.lines, sibling_start, range.level)
        local block = vim.api.nvim_buf_get_lines(bufnr, range.start_line - 1, range.end_line, false)
        local sibling_block = vim.api.nvim_buf_get_lines(bufnr, sibling_start - 1, sibling_end, false)

        if direction == 'up' then
          vim.api.nvim_buf_set_lines(bufnr, sibling_start - 1, range.end_line, false, vim.list_extend(block, sibling_block))
          local new_cursor_line = sibling_start + (vim.api.nvim_win_get_cursor(0)[1] - range.start_line)
          vim.api.nvim_win_set_cursor(0, { new_cursor_line, vim.api.nvim_win_get_cursor(0)[2] })
        else
          vim.api.nvim_buf_set_lines(bufnr, range.start_line - 1, sibling_end, false, vim.list_extend(sibling_block, block))
          local new_cursor_line = sibling_end - #block + 1 + (vim.api.nvim_win_get_cursor(0)[1] - range.start_line)
          vim.api.nvim_win_set_cursor(0, { new_cursor_line, vim.api.nvim_win_get_cursor(0)[2] })
        end
      end

      local function markdown_header_command(command)
        vim.cmd 'normal ]h'
        vim.cmd('.,.' .. command)
      end

      local function toggle_heading_fold()
        local range = current_heading_range(vim.api.nvim_get_current_buf())
        if not range or range.start_line == range.end_line then
          return
        end

        local cursor = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_win_set_cursor(0, { math.min(range.start_line + 1, range.end_line), 0 })

        if vim.fn.foldclosed '.' == -1 then
          vim.cmd.normal { 'zc', bang = true }
        else
          vim.cmd.normal { 'zo', bang = true }
        end

        vim.api.nvim_win_set_cursor(0, cursor)
      end

      local function insert_heading_below()
        local bufnr = vim.api.nvim_get_current_buf()
        local range = current_heading_range(bufnr)
        if not range then
          vim.notify('Cursor is not inside a markdown heading', vim.log.levels.WARN)
          return
        end

        local new_heading = string.rep('#', range.level) .. ' '
        vim.api.nvim_buf_set_lines(bufnr, range.end_line, range.end_line, false, { '', new_heading })
        vim.api.nvim_win_set_cursor(0, { range.end_line + 2, #new_heading })
        vim.cmd.startinsert()
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function(event)
          local opts = { buffer = event.buf, noremap = true, silent = true }
          local remap_opts = { buffer = event.buf, remap = true, silent = true }
          vim.opt_local.foldmethod = 'expr'
          vim.opt_local.foldexpr = 'v:lua.markdown_heading_foldexpr(v:lnum)'
          vim.opt_local.foldlevel = 99
          vim.opt_local.foldlevelstart = 99

          vim.keymap.set('n', '<Tab>', toggle_heading_fold, vim.tbl_extend('force', opts, { desc = 'Markdown toggle heading fold' }))
          vim.keymap.set('n', '<C-j>', '][', vim.tbl_extend('force', remap_opts, { desc = 'Markdown next sibling heading' }))
          vim.keymap.set('n', '<C-k>', '[]', vim.tbl_extend('force', remap_opts, { desc = 'Markdown previous sibling heading' }))
          vim.keymap.set('n', '<C-l>', ']]', vim.tbl_extend('force', remap_opts, { desc = 'Markdown next heading' }))
          vim.keymap.set('n', '<C-h>', ']u', vim.tbl_extend('force', remap_opts, { desc = 'Markdown parent heading' }))
          vim.keymap.set('n', '<D-h>', function()
            markdown_header_command 'HeaderDecrease'
          end, vim.tbl_extend('force', opts, { desc = 'Markdown promote heading' }))
          vim.keymap.set('n', '<D-l>', function()
            markdown_header_command 'HeaderIncrease'
          end, vim.tbl_extend('force', opts, { desc = 'Markdown demote heading' }))
          vim.keymap.set('n', '<D-k>', function()
            move_heading 'up'
          end, vim.tbl_extend('force', opts, { desc = 'Markdown move heading up' }))
          vim.keymap.set('n', '<D-j>', function()
            move_heading 'down'
          end, vim.tbl_extend('force', opts, { desc = 'Markdown move heading down' }))
          vim.keymap.set('n', '<leader>ol', 'ge', vim.tbl_extend('force', opts, { desc = '[O]pen markdown [L]ink' }))
          vim.keymap.set({ 'n', 'i' }, '<C-Enter>', insert_heading_below, vim.tbl_extend('force', opts, { desc = 'Markdown insert heading below' }))
        end,
      })
    end,
  },
}
