require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 2048
IRB.conf[:PROMPT_MODE] = :SIMPLE
