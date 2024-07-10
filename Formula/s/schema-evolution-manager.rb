class SchemaEvolutionManager < Formula
  desc "Manage postgresql database schema migrations"
  homepage "https://github.com/mbryzek/schema-evolution-manager"
  url "https://github.com/mbryzek/schema-evolution-manager/archive/refs/tags/0.9.53.tar.gz"
  sha256 "699a184a2725ce6cd878ea219fba4c5f7ca937c44386435c24fe0a9c9c224445"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8768c530ce69593150340ea0c6a75b14d42802f0d9005020276c35fea68b81dc"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8768c530ce69593150340ea0c6a75b14d42802f0d9005020276c35fea68b81dc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8768c530ce69593150340ea0c6a75b14d42802f0d9005020276c35fea68b81dc"
    sha256 cellar: :any_skip_relocation, sonoma:         "8768c530ce69593150340ea0c6a75b14d42802f0d9005020276c35fea68b81dc"
    sha256 cellar: :any_skip_relocation, ventura:        "8768c530ce69593150340ea0c6a75b14d42802f0d9005020276c35fea68b81dc"
    sha256 cellar: :any_skip_relocation, monterey:       "8768c530ce69593150340ea0c6a75b14d42802f0d9005020276c35fea68b81dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "75b0dae0c12ec18579ce05a9e992e51abc6822bea440244ad9efed34dd51a667"
  end

  uses_from_macos "ruby"

  def install
    system "./install.sh", prefix
  end

  test do
    (testpath/"new.sql").write <<~EOS
      CREATE TABLE IF NOT EXISTS test (id text);
    EOS
    system "git", "init", "."
    assert_match "File staged in git", shell_output("#{bin}/sem-add ./new.sql")
  end
end
