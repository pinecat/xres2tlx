# frozen_string_literal: true

require "xres2tlx/converter"
require_relative "xres2tlx/version"

module Xres2tlx
  class Error < StandardError; end

  def self.init(args)
    # Check the args
    if args.length == 0 || args.length > 1
      warn "Usage: xres2tlx <path-to-xresources-file>"
      exit 1
    end

    # Create the converter, and do the conversion
    conv = Converter.new(args[0])
    conv.read_xres_file
    conv.set_tlx_pref
    conv.output_tlx_file
  end
end
