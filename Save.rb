require 'yaml'

class Save
  FILE = 'serial.yaml'
  
  def save_state(game)
    File.write(FILE, YAML.dump(game))
    puts "Game saved."  
  end

  def load_state
    YAML.load_file(
      FILE,
      permitted_classes: [Game],
      aliases: true
    )  end
end