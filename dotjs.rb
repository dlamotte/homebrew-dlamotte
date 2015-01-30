require 'formula'

class Dotjs < Formula
  url 'https://github.com/defunkt/dotjs/tarball/2.0'
  head 'https://github.com/defunkt/dotjs.git'
  homepage 'http://chriswanstrath.com/dotjs/'
  sha1 '77a155ae61c25811771802c4cb45b63ac07e4392'

  def install
    # daemon
    bin.install "bin/djsd"

    # chrome
    system "open", "-a", "Google Chrome", "http://bit.ly/dotjs"

    # agent
    agent = File.expand_path "~/Library/LaunchAgents/com.github.dotjs.plist"
    mkdir_p File.dirname(agent)
    File.open(agent, "w") do |f|
      f.puts ERB.new(IO.read("com.github.dotjs.plist")).result(binding)
    end
    chmod 0644, agent
    system "launchctl", "load", "-w", agent

    system "open", "-a", "Google Chrome", "https://localhost:3131"
    system "open", "-a", "Google Chrome", "http://cl.ly/Pdny"
  end
end
