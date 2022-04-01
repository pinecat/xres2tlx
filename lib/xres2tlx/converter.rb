# frozen_string_literal: true

require "json"

class Converter
  def initialize(filepath)
    # Check if the file exists
    unless File.exist?(filepath)
      warn "xres2tlx: Could not find the file: #{filepath}, quitting..."
      exit 1
    end

    # Set the xres_filepath
    @xres_filepath = filepath
    @unordered_pref = {palette: []}
    @tlx_pref = nil
  end

  def read_xres_file
    # Read the file
    text = File.read(@xres_filepath)

    # Split text by line, and iterate over each line
    text.split("\n").each do |line|
      # Only set values if line does not begin with the comment character ('!')
      unless line[0] == "!"
        # Get the hex value
        color = line.split(":").last.strip.upcase.chomp

        # Set preferences
        @unordered_pref["background-color"] = color if line.include? "background" # Background color
        @unordered_pref["foreground-color"] = color if line.include? "foreground" # Foreground color
        @unordered_pref["cursor-background-color"] = color if line.include? "cursorColor" # Cursor color
        @unordered_pref["cursor-foreground-color"] = color if line.include? "cursorColor" # Cursor color
        @unordered_pref["bold-color"] = color if line.include? "colorBD" # Bold color

        # Palette
        # Only set palette if line just includes "color", NOT "colorBD"
        unless line.include? "colorBD"
          @unordered_pref[:palette].push(color) if line.include? "color"
        end
      end
    end
  end

  def set_tlx_pref
    @tlx_pref = {
      "background-color": @unordered_pref["background-color"],
      "badge-color": "#FFFFFF",
      "bold-color": @unordered_pref["bold-color"],
      comment: "This colorscheme was generated using xres2tlx.",
      "cursor-background-color": @unordered_pref["cursor-background-color"],
      "cursor-foreground-color": @unordered_pref["cursor-foreground-color"],
      "foreground-color": @unordered_pref["foreground-color"],
      "highlight-background-color": "#000000",
      "highlight-foreground-color": "#FFFFFF",
      name: @xres_filepath.split("/").last.strip.chomp,
      palette: @unordered_pref[:palette],
      "use-badge-color": false,
      "use-bold-color": true,
      "use-cursor-color": true,
      "use-highlight-color": false,
      "use-theme-colors": false
    }
  end

  def output_tlx_file
    puts JSON.pretty_generate(@tlx_pref)
  end
end
