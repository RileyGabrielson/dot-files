local templates = function()
  vim.ui.select(
    {"React Component", "Test"},
    { prompt = 'Template Name: ' },
    function(input)

      if input == "React Component" then
        vim.ui.input(
          { prompt = 'Component Name: '},
          function(componentName)
            if componentName == "" then return end
            vim.api.nvim_buf_set_lines(0, 0, -1, false, {
              "import React from 'react';",
              "",
              "interface " .. componentName .. "Props {",
              "",
              "}",
              "",
              "const " .. componentName .. " = ({}: " .. componentName .. "Props) => {",
              "",
              "}"
            });
            vim.cmd"8"
          end
        )
      end

      if input == "Test" then
        vim.ui.input(
          { prompt = 'Domain Name: '},
          function(componentName)
            if componentName == "" then return end
            vim.api.nvim_buf_set_lines(0, 0, -1, false, {
              "",
              "describe('" .. componentName .. " should...\', () => {",
              "  test('', () => {",
              "    ",
              "  });",
              "});"
            });
            vim.cmd"cal cursor(3,8)"
          end
        )
      end

    end
  )
end

return templates

