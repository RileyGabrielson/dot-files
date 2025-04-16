local stdpath = vim.fn.stdpath("data") .. "/mason/bin/"

require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		-- command = "node",
		-- args = { stdpath .. "js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
		command = stdpath .. "js-debug-adapter",
		args = { "${port}" },
	},
}

require("dap").configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		runtimeExecutable = "deno",
		runtimeArgs = {
			"run",
			"--inspect-wait",
			"--allow-all",
		},
		program = "${file}",
		cwd = "${workspaceFolder}",
		attachSimplePort = 9229,
	},
}
