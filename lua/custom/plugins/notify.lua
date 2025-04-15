return {
  'rcarriga/nvim-notify',
  config = function()
    vim.notify = require 'notify' -- override default notify
  end,
  keys = {
    {
      'K',
      function()
        local params = vim.lsp.util.make_position_params(0, 'utf-8')

        vim.lsp.buf_request(0, 'textDocument/hover', params, function(err, result)
          if err or not result or not result.contents then
            -- vim.notify('No hover information available', 'warn', { title = 'LSP Hover' })
            return
          end

          vim.notify(result.contents.value, vim.log.levels.INFO, {
            title = 'Type Information',
            timeout = 5000,
          })
        end)
      end,
      desc = 'Show type information with notify',
      mode = 'n',
    },
  },
}
