local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then return end

local XML_FILE = 'package.xml'

local function get_catkin_build_path()
    local handle = io.popen [[catkin config | grep "Build Space" | awk '{print $4}']]
    local build_path = handle:read('*l')
    string.gsub(build_path, '\n$', '')
    return build_path
end

return {
    cmd = {'clangd', '--background-index'},
    on_new_config = function(new_config)
        local root_dir = new_config.root_dir(vim.api.nvim_buf_get_name(0), vim.api.nvim_get_current_buf())

        -- Find the name of the package by parsing the XML_FILE
        local reader = require'xmlreader'.from_file(('%s/%s'):format(root_dir, XML_FILE))
        while (reader:read()) do
            if (reader:node_type() == 'element' and reader:name() == 'name') then
                local pkg_name = reader:read_string()
                local compile_flag = ('--compile-commands-dir=%s/%s'):format(get_catkin_build_path(), pkg_name)
                vim.list_extend(new_config.cmd, {compile_flag})
                break
            end
        end
    end,
    root_dir = function(fname) return require'lspconfig.util'.root_pattern(XML_FILE)(fname) end
}
