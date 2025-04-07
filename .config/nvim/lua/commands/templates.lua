local function first_to_upper(str)
	return (str:gsub("^%l", string.upper))
end

local function get_component_name(suffix)
	local file_path = vim.fn.expand("%:.")
	local stripped_path = file_path:gsub("(.*)/", "")
	local file_name = stripped_path:gsub(suffix, "")
	local domain_name = ""
	for word in string.gmatch(file_name, "([^_]+)") do
		domain_name = domain_name .. first_to_upper(word)
	end
	return domain_name
end

local function add_react_template()
	local component_name = get_component_name(".tsx")
	vim.api.nvim_buf_set_lines(0, 0, -1, false, {
		"import React from 'react';",
		"",
		"interface " .. component_name .. "Props {",
		"",
		"}",
		"",
		"export const " .. component_name .. " = ({}: " .. component_name .. "Props) => {",
		"",
		"}",
	})
	vim.cmd("8")
end

local function add_jest_template()
	local component_name = get_component_name(".test.ts")

	vim.api.nvim_buf_set_lines(0, 0, -1, false, {
		"describe('" .. component_name .. " should...', () => {",
		"  test('', () => {",
		"    ",
		"  });",
		"});",
	})
	vim.cmd("cal cursor(2,8)")
end

local function add_domain_template()
	local component_name = get_component_name(".ts")
	vim.api.nvim_buf_set_lines(0, 0, -1, false, {
		"import { ObservableValue } from '@m/hex/observable_value';",
		"",
		"interface " .. component_name .. "Port {",
		"  ",
		"}",
		"",
		"export class " .. component_name .. " {",
		"  private adapter: " .. component_name .. "Port;",
		"",
		"  constructor(adapter: " .. component_name .. "Port) {",
		"    this.adapter = adapter;",
		"  }",
		"}",
	})
	vim.cmd("cal cursor(4,2)")
end

local templates = function()
	vim.ui.select({ "React Component", "Jest Test", "Domain" }, { prompt = "Template Name: " }, function(input)
		if input == "React Component" then
			add_react_template()
		end
		if input == "Jest Test" then
			add_jest_template()
		end
		if input == "Domain" then
			add_domain_template()
		end
	end)
end

return templates
