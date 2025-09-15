require("leap").set_default_mappings()
require("leap").opts.preview_filter = function(ch0, ch1, ch2)
	return not (ch1:match("%s") or ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
end
require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
require("leap.user").set_repeat_keys("<enter>", "<backspace>")

-- Show the preview character first
require("leap").opts.on_beacons = function(targets, _, _)
	for _, t in ipairs(targets) do
		if t.label and t.beacon then
			t.beacon[1] = 0
		end
	end
end
