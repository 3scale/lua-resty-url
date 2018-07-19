
Roverfile.lock: Roverfile
	rover lock

lua_modules: Roverfile.lock Roverfile
	rover install

test:
	@resty -e "require('busted.runner')({ standalone = false })"
