local defineClassesObject = "o  const classes = useStyles();<Esc>"
local find_last_import = "?import<CR>/;<CR>o"
local make_styles_import = "import { makeStyles } from '@m/ergo/hooks/make_styles';"
local function_statment = "const useStyles = makeStyles(theme => ({<CR><CR>}));"
local cleanup = "<Esc>:noh<CR>ki<Tab>"

return defineClassesObject .. find_last_import .. make_styles_import .. "<CR><CR>" .. function_statment .. cleanup
