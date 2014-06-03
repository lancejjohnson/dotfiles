if defined?(PryByebug)
  Pry.commands.alias_command 'cc', 'continue'
  Pry.commands.alias_command 'ss', 'step'
  Pry.commands.alias_command 'nn', 'next'
  Pry.commands.alias_command 'ff', 'finish'
  Pry.commands.alias_command 'ww', 'whereami'
end

# Hit Enter to repeat last command
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end
