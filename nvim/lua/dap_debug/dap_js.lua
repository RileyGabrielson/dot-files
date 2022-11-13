require("dap").adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js"} -- TODO adjust
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch File (Node)",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeArgs = {
        "node_modules/jest/bin/jest.js",
      },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach (Node)",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "chrome",
      request = "attach",
      name = "Attach (Chrome)",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }
end
