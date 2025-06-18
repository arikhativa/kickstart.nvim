-- NOTE: we dont use this now
return {
  filetypes = { 'markdown', 'latex', 'norg', 'gitcommit', 'text', 'typst', 'typescript', 'javascript', 'json', 'lua', 'tsx', 'typescriptreact' },
  settings = {
    ltex = {
      language = 'en-US',
      diagnosticSeverity = 'information',
      sentenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        -- motherTongue = "en", -- Uncomment and set if you want to use mother tongue rules
      },
      enabledRules = {
        -- en = { "EN_CONSISTENT_APOS" },
      },
      disabledRules = {
        en = { 'DASH_RULE' },
      },
      dictionary = {
        -- You can add custom dictionary words here
        -- en = { "mycustomword", "anotherword" },
      },
      languageSpecific = {
        ['he'] = {
          language = 'he-IL', -- Set language to Hebrew for Hebrew files
        },
      },
    },
  },
}
