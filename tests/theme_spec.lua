-- vim.fn.stdpath is monkey-patched per-test so these specs never touch the
-- real persisted theme state file at stdpath("state")/nvim-config-theme.
describe(":SetTheme + theme/state.lua persistence", function()
  local state
  local tmp_state_dir
  local orig_stdpath

  before_each(function()
    tmp_state_dir = vim.fn.tempname()
    vim.fn.mkdir(tmp_state_dir, "p")
    orig_stdpath = vim.fn.stdpath
    vim.fn.stdpath = function(what)
      if what == "state" then
        return tmp_state_dir
      end
      return orig_stdpath(what)
    end
    package.loaded["theme.state"] = nil
    state = require "theme.state"
  end)

  after_each(function()
    vim.fn.stdpath = orig_stdpath
    package.loaded["theme.state"] = nil
    vim.fn.delete(tmp_state_dir, "rf")
  end)

  it("returns the given default when no state file exists yet", function()
    assert.are.equal("fallback", state.read "fallback")
  end)

  it("persists a written theme name and reads it back", function()
    state.write "onedark"
    assert.are.equal("onedark", state.read "fallback")
  end)

  it(":SetTheme sets vim.g.colors_name and persists the choice", function()
    vim.g.colors_name = nil
    vim.cmd "SetTheme onedark"
    assert.are.equal("onedark", vim.g.colors_name)
    assert.are.equal("onedark", state.read "fallback")
  end)
end)
