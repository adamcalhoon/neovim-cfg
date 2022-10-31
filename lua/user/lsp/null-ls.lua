local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then return end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		formatting.black.with({ extra_args = { "--line-length=120", "--fast" } }),
		formatting.prettier.with({ extra_args = { "--print-width=120", "--tab-width=4", "--use-tabs=false" } })
	},
})
