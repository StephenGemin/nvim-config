vim.api.nvim_create_user_command("SetTheme", function(opts)
  vim.cmd.colorscheme(opts.args)
  require("theme.state").write(opts.args)
end, {
  nargs = 1,
  complete = function(arg_lead)
    local seen = {}
    for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/themes/*.lua", true)) do
      local name = vim.fn.fnamemodify(file, ":t:r")
      if vim.startswith(name, arg_lead) then
        seen[name] = true
      end
    end
    return vim.tbl_keys(seen)
  end,
  desc = "Switch colorscheme and persist it across restarts",
})
