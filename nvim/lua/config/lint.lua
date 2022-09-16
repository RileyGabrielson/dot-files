local nvim_lint = require('lint')

nvim_lint.linters_by_ft = {typescript = {'eslint'}}
nvim_lint.linters.eslint.args = {'--config ~/r/neo/tools/ui/frontend-scripts/src/config/eslintrc.js'}
