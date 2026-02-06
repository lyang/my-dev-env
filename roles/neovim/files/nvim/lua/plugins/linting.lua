return {
  "mfussenegger/nvim-lint",
  event = "BufReadPre",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      yaml = { "actionlint" },
    }

    -- Only run actionlint on GitHub Actions workflow files
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      callback = function()
        local path = vim.fn.expand("%:p")
        if path:match("%.github/workflows/") then
          lint.try_lint()
        end
      end,
    })
  end,
}
