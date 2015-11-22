# Pry.config.commands.import Pry::ExtendedCommands::Experimental

Pry.config.pager = false
Pry.config.color = true

Pry.config.commands.alias_command "lM", "ls -M"

Pry.config.commands.command "add", "Add a list of numbers together" do |*args|
  output.puts "Result is: #{args.map(&:to_i).inject(&:+)}"
end

# Pry.config.prompt = [proc { "input> " },
#                     proc { "     | " }]

