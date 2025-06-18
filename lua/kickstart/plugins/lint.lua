return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      -- lint.linters.cspell = {
      --   cmd = { 'cspell' },
      --   args = {
      --     'lint',
      --     '--no-summary',
      --     '--no-progress',
      --     '--relative',
      --     '--dot',
      --     '--gitignore',
      --     '--no-must-find-files',
      --     '--quiet',
      --     '--json',
      --     vim.fn.expand '%:p',
      --   },
      --
      --   parser = function(output, bufnr)
      --     local diagnostics = {}
      --     local parsed_json = util.parse_json(output) -- Use lint.util.parse_json
      --
      --     -- Check if parsing was successful and if there are issues
      --     if parsed_json and parsed_json.issues then
      --       for _, issue in ipairs(parsed_json.issues) do
      --         -- Map cspell's severity to Neovim's diagnostic severity
      --         local severity = vim.diagnostic.severity.INFO -- Default to INFO
      --         if issue.severity == 'error' then
      --           severity = vim.diagnostic.severity.ERROR
      --         elseif issue.severity == 'warning' then
      --           severity = vim.diagnostic.severity.WARN
      --         elseif issue.severity == 'information' then
      --           severity = vim.diagnostic.severity.INFO
      --         elseif issue.severity == 'hint' or issue.severity == 'suggestion' then
      --           severity = vim.diagnostic.severity.HINT
      --         end
      --
      --         table.insert(diagnostics, {
      --           bufnr = bufnr,
      --           lnum = issue.row - 1, -- Neovim is 0-indexed for lines
      --           col = issue.col - 1, -- Neovim is 0-indexed for columns
      --           end_lnum = issue.row - 1,
      --           end_col = issue.col - 1 + #issue.text, -- Highlight the whole word
      --           message = issue.message,
      --           source = 'cspell',
      --           code = issue.issueType,
      --           severity = severity,
      --         })
      --       end
      --     end
      --     return diagnostics
      --   end,
      -- }

      lint.linters_by_ft = {
        ['*'] = { 'cspell' },
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescriptreact = { 'eslint' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      -- local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      -- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      --   group = lint_augroup,
      --   callback = function()
      --     -- Only run the linter in buffers that you can modify in order to
      --     -- avoid superfluous noise, notably within the handy LSP pop-ups that
      --     -- describe the hovered symbol using Markdown.
      --     if vim.opt_local.modifiable:get() then
      --       lint.try_lint()
      --     end
      --   end,
      -- })

      -- NOTE:
      -- Instead of autocmd, set a manual keymap
      vim.keymap.set('n', '<leader>lf', function()
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end, { desc = 'Lint current file' })
    end,
  },
}
