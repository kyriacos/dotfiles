require 'readline'
require 'irb/completion'
IRB.conf[:IRB_RC] = lambda do |conf|
  conf.auto_indent_mode = true
  conf.save_history = 200
  conf.use_readline = true
end
