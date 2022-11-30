local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

configs.setup({
    ensure_installed = "all",
    ignore_install = {""},
    highlight = {enable = true, disable = {"css"}},
    autopairs = {enable = true},
    indent = {enable = true, disable = {"c", "cpp", "css", "python"}},
    disable = function(lang, bufnr)
        -- Disable in large buffers
        return api.nvim_buf_line_count(bufnr) > 25000
    end,
})
