-- https://github.com/rmagatti/auto-session

return {
	"rmagatti/auto-session",
	lazy = false,
	priority = 1000, -- load before the dashboard needs to query session list
	opts = {
		log_level = "error",
		auto_session_enable_last_session = false,
		auto_session_enabled = true,
		auto_save_enabled = true,
		auto_restore_enabled = true,
		auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
		-- Required so that the dashboard's "recent project" buttons (which
		-- just `:cd` into a project root) actually trigger a session
		-- restore for that directory, instead of only changing cwd.
		cwd_change_handling = true,
		-- keep neo-tree state and cwd consistent across session restores
		session_lens = {
			load_on_setup = false, -- we build our own picker on the dashboard
		},
	},
}
