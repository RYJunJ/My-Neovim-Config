-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = "/Users/junjie/JavaWorkSpace/" .. project_name
--                                               ^^
--                                               string concattenation in Lua

local config = {
	cmd = { "/opt/homebrew/bin/jdtls", "-data", workspace_dir },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
	init_options = {
		bundles = {
			vim.fn.glob(
				"/Users/junjie/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.0.jar",
				1
			),
		},
	},
}
require("jdtls").start_or_attach(config)
