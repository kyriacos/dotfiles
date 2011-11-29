require 'readline'
require 'irb/completion'
require 'what_methods'
require 'ap'
require 'pp'
IRB.conf[:IRB_RC] = lambda do |conf|
  conf.auto_indent_mode = true
  conf.save_history = 200
  conf.use_readline = true
end

#def print_history
  #if [].respond_to?(:split)
    #puts Readline::HISTORY.entries.split("exit").last[0..-2].join("\n")
  #else
    #puts Readline::HISTORY.entries
  #end
#end

def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
  copy content
end

def paste
  `pbpaste`
end


#load railsrc
load File.dirname(__FILE__) + '/.railsrc' if ($0 == 'irb' && ENV['RAILS_ENV']) || ($0 == 'script/rails' && Rails.env)

