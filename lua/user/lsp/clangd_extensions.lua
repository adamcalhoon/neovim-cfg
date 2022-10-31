local status_ok, clangd_ext = pcall(require, 'clangd_extensions')
if not status_ok then return end

clangd_ext.setup {
    server = require('user.lsp.settings.clangd'),

    extensions = {
        ast = {
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },
        }
    }
}
