require("dapui").setup()
require("nvim-dap-virtual-text").setup()
require("mason-nvim-dap").setup()

require("dap-vscode-js").setup({
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"/home/khang/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

require("dap").adapters["node-terminal"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"/home/khang/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

require("dap").adapters["pwa-chrome"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"/home/khang/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

local custom_adapter = 'pwa-node-custom'

for _, language in ipairs({ "typescript", "javascript", "vue" }) do
        require("dap").configurations[language] = {
                {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",

                },
                {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        cwd = "${workspaceFolder}",
                },
                {
                        type = "pwa-chrome",
                        request = "launch",
                        name = "Start Chrome with \"localhost\"",
                        url = "http://localhost:3000",
                        webRoot = "${workspaceFolder}",
                        userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
                }
        }
end

