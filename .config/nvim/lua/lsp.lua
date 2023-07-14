require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "tsserver", "vuels", "yamlls", "ruby_ls" }
})

local on_attach = function()
	vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, {})
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()


require("lspconfig").lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}

require'lspconfig'.gopls.setup{
	on_attach = on_attach,
	capabilities = capabilities
}

require'lspconfig'.nil_ls.setup{
	on_attach = on_attach,
	capabilities = capabilities
}

require'lspconfig'.tsserver.setup{
	on_attach = on_attach,
	capabilities = capabilities
}

require'lspconfig'.vuels.setup{
	on_attach = on_attach,
	capabilities = capabilities
}

require'lspconfig'.solargraph.setup{
	on_attach = on_attach,
	capabilities = capabilities
}

require'lspconfig'.yamlls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
  settings = {
        yaml = {
            schemas = {
                    ["https://raw.githubusercontent.com/aws/serverless-application-model/main/samtranslator/schema/schema.json"] = {
                        "/template.yaml",
                        "/cloudformation/*.yaml"
                    }
            },
            customTags = { "!Ref", "!ImportValue", "!Sub", "!GetAtt" }
        }
    }
}
