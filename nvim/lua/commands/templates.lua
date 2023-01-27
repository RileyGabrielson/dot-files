local function first_to_upper(str)
  return (str:gsub("^%l", string.upper))
end

local function get_component_name(suffix)
  local file_path = vim.fn.expand("%:.");
  local stripped_path = file_path:gsub("(.*)/", "");
  local file_name = stripped_path:gsub(suffix, "");
  local domain_name = "";
  for word in string.gmatch(file_name, '([^_]+)') do
    domain_name = domain_name .. first_to_upper(word);
  end
  return domain_name;
end

local function get_test_import_path()
	local file_path = vim.fn.expand("%:.")
	if file_path == "" then
		return nil;
	end

  local without_test_folder = file_path:gsub("__tests__/", "")

	if string.find(without_test_folder, "commons/ui") then
    return without_test_folder:gsub("^(commons/)ui/(.*).test.ts$", "@neo/%1%2");
	elseif string.find(without_test_folder, "ui/operator/src") then
		return without_test_folder:gsub("^ui(.*).test.ts$", "@neo%1")
	else
    return without_test_folder;
	end
end

local function add_react_template()
  local component_name = get_component_name(".tsx");
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "import React from 'react';",
    "",
    "interface " .. component_name .. "Props {",
    "",
    "}",
    "",
    "export const " .. component_name .. " = ({}: " .. component_name .. "Props) => {",
    "",
    "}"
  });
  vim.cmd"8"
end

local function add_jest_template()
  local component_name = get_component_name(".test.ts");
  local import_file_path = get_test_import_path();

  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "import { " .. component_name .. " } from '" .. import_file_path .. "';",
    "",
    "describe('" .. component_name .. " should...\', () => {",
    "  test('', () => {",
    "    ",
    "  });",
    "});"
  });
  vim.cmd"cal cursor(4,8)"
end

local function add_domain_template()
  local component_name = get_component_name(".ts");
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "import { ObservableValue } from '@neo/hex';",
    "",
    "interface " .. component_name .. "Port {",
    "  ",
    "}",
    "",
    "export class " .. component_name .. " {",
    "",
    "  constructor({}: " .. component_name .. "Port) {",
    "",
    "  }",
    "}"
  });
  vim.cmd"cal cursor(4,2)"
end

local templates = function()
  vim.ui.select(
    {"React Component", "Jest Test", "Domain"},
    { prompt = 'Template Name: ' },
    function(input)
      if input == "React Component" then add_react_template() end
      if input == "Jest Test" then add_jest_template() end
      if input == "Domain" then add_domain_template() end
    end
  )
end

return templates
