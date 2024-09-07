-- all files called are in the lua/starter folder
-- the plugins are in the lua/plugins folder

require 'starter.configuration'

require 'starter.newCmd'

require 'starter.autoCmd'

require 'starter.lazyconfig'

require 'plugins.oilPl.oilSetup'

require 'plugins.bufferlineSetup'

require 'LSP.LSPsetup'

--Godot
require 'LSP.godotConfig'
