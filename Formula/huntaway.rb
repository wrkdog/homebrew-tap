class Huntaway < Formula
  desc "Queue Claude Code and Codex jobs on your own subscriptions"
  homepage "https://github.com/wrkdog/huntaway"
  url "https://registry.npmjs.org/@wrkdog/huntaway/-/huntaway-0.1.1.tgz"
  sha256 "775a36faf004f425f53d8d4c4ea7997d3fcc968e463847cde37f4d207d347d3d"
  license "Apache-2.0"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    %w[huntaway pipe pipe-mcp].each do |name|
      (bin/name).write <<~SH
        #!/bin/sh
        exec "#{Formula["node"].opt_bin}/node" "#{libexec}/npm/#{name}.mjs" "$@"
      SH
      chmod 0755, bin/name
    end
  end

  test do
    assert_match "0.1.1", shell_output("#{bin}/huntaway --version")
  end
end
