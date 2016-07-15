# courtesy of http://github.com/ryanb/dotfiles/Rakefile
require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir.chdir('dots');
  Dir.glob('*') do |file|
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
        puts "identical ~/.#{file.sub('.erb', '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end

  end
  print "would you like to remove the global zshenv file? [yn] "
  if $stdin.gets.chomp == "y"
    remove_global_zshenv
  end
end

desc "remove the global zshenv so you can get the right path in macvim"
task :remove_global_zshenv do
  remove_global_zshenv
end

desc "OSX Lion hacks and annoyances"
task :lion_osx_hacks do
  #disable_resume_preview_lion
  #osx_hacks
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$HOME/.dotfiles/dots/#{file}" "$HOME/.#{file}"}
  end
end

def remove_global_zshenv
  if File.exists? "/etc/zshenv"
    print "renaming /etc/zshenv to /etc/zshenv_backup\n"
    system %Q{sudo mv /etc/zshenv /etc/zshenv_backup}
  end
end

def disable_resume_preview_lion
  print "Disable resume feature in Preview for OSX Lion? Seems to kill my laptop [yn]"
  if $stdin.gets.chomp == "y"
    system %Q{sudo defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false}
  end
end

def osx_hacks
  print "Things like stupid repeat rate on lion [yn]"
  if $stdin.gets.chomp == "y"
    # Disable press-and-hold for keys in favor of key repeat
    system %Q{defaults write -g ApplePressAndHoldEnabled -bool false}
    # Use AirDrop over every interface. srsly this should be a default.
    system %Q{defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1}
    # Show the ~/Library folder
    system %Q{chflags nohidden ~/Library}

    print "Allow text selection in the Quick Look window"
    system %Q{defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder}
  end
end
