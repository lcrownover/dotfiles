return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-]>",
                    dismiss = "<C-[>",
				},
			},
			filetypes = {
				yaml = true,
			},
		})
	end,
}
