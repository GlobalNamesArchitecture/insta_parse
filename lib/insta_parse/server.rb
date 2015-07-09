class Server
  def initialize(port)
    @port = port
    @server = TCPServer.open(@port)
  end

  def run
    loop do
      Thread.start(@server.accept) do |client|
        puts 'opening client'
        count = 0
        while a = client.readline rescue nil
          count += 1
          puts "parsed %s'th name" % count if count % 1000 == 0
          a.force_encoding('utf-8') if a && RUBY_VERSION_INT >= 19
          if ['end','exit','q', '.'].include? a.strip
            client.close
            break
          end
          out = get_output(a, parser).strip
          client.write(out + "\n") rescue break
        end
        puts 'closing client'
        client.close
      end
    end

  end
end
