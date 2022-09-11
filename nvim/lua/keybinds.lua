function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


vim.g.mapleader = " "

map("n", "<Leader>`", ":e ~/dot-files/nvim/init.lua<CR>")
map("n", "<Leader>q", ":q<CR>", { silent = true })
map("n", "Y", "y$")
map("n", "<Tab>", "<C-w><C-w>")
map("n", "<Leader><Tab>", "<C-^>")

map("n", "<Leader>w", "<Plug>(easymotion-w)")
map("n", "<Leader>b", "<Plug>(easymotion-b)")
map("n", "<Leader>e", ":NERDTreeFocus<CR>")
map("n", "<Leader>E", ":NERDTreeToggle<CR>")
map("n", "<Leader>h", ":NERDTreeFind<CR>")

map("n", "<Leader>gb", "<cmd>GitBlameToggle<CR>")
map("n", "<Leader>gs", ":Gitsigns toggle_signs<CR>:Gitsigns toggle_numhl<CR>")

map("v", "<Leader>c", ":'<,'>CommentToggle<CR>")
map("n", "<Leader>c", "<cmd>CommentToggle<CR>")

map("n", "<Leader>f", ":Ag<CR>")
map("n", "<C-p>", ":GFiles<CR>")
map("n", "<Leader>p", ":GFiles<CR>")
map("n", "<C-P>", ":Files<CR>")
map("n", "<Leader>P", ":Files<CR>")

map("n", "<Leader>td", "<cmd>Trouble document_diagnostics<CR>")
map("n", "<Leader>tw", "<cmd>Trouble workplace_diagnostics<CR>")
map("n", "<Leader>tr", "<cmd>Trouble lsp_references<CR>")
map("n", "<Leader>tg", "<cmd>Trouble lsp_definitions<CR>")
map("n", "<Leader>tt", "<cmd>Trouble lsp_type_definitions<CR>")

map("n", "<Leader>g", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<Leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<Leader>r", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<Leader>s", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<Leader>.", "<cmd>lua vim.lsp.buf.code_action()<CR>")

map("t", "<C-\\>", "<C-\\><C-n>")
