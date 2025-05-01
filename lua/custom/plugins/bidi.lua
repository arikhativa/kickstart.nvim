return {
  'mcookly/bidi.nvim',
  lazy = false, -- Load on startup
  config = function()
    require('bidi').setup()
  end,
}
