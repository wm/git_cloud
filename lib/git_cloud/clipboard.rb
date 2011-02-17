# Clipboard is a centralized point to shell out to each individual platform's
# clipboard, pasteboard, or whatever they decide to call it.
#
module GitCloud
  class Clipboard
    class << self

      # Public: copies the given text to the clipboard. This method is
      # designed to handle multiple platforms.
      #
      # text - String to copy to the clipboard
      #
      # Returns nothing.
      def copy(text)
        copy_command =
          if RUBY_PLATFORM =~ /darwin/
            "pbcopy"
          else
            "xclip -selection clipboard"
          end

        `echo #{text} | #{copy_command}`

        "Copied #{text} to your clipboard."
      end

    end
  end
end
