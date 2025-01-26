-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = "/home/junjie/JavaWorkSpace/" .. project_name
--                                               ^^
--                                               string concattenation in Lua

local config = {
	on_attach = function(client, bufnr)
		-- 启用格式化功能
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
		-- 添加快捷键映射或其他设置
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>j", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
	end,
	cmd = { "/home/junjie/.local/share/nvim/mason/bin/jdtls", "-data", workspace_dir },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
	settings = {
		java = {
			format = {
				settings = {
					url = "/home/junjie/.config/nvim/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
					tabSize = 2,
					indentSize = 2,
					insertSpaces = true,
				},
			},
		},
	},
	init_options = {
		bundles = {
			--vim.fn.glob(
			--	"/Users/junjie/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.0.jar",
			--	1
			--),
		},
	},
}
require("jdtls").start_or_attach(config)
