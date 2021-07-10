class Qcachegrind < Formula
  desc "Visualize data generated by Cachegrind and Calltree"
  homepage "https://kcachegrind.github.io/"
  url "https://download.kde.org/stable/release-service/21.04.3/src/kcachegrind-21.04.3.tar.xz"
  sha256 "25d01173e31b8715bd1b22546ef9c39cf4f555d9860a106d34588bae55793926"
  license "GPL-2.0-or-later"

  # We don't match versions like 19.07.80 or 19.07.90 where the patch number
  # is 80+ (beta) or 90+ (RC), as these aren't stable releases.
  livecheck do
    url "https://download.kde.org/stable/release-service/"
    regex(%r{href=.*?v?(\d+\.\d+\.(?:(?![89]\d)\d+)(?:\.\d+)*)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "4326dcdb3dcb621e8ded1bd58b63b9d9e54226e23cb8ceb228832b872c2bb224"
    sha256 cellar: :any, big_sur:       "1ff0f8fc30714a55a0bf149751507453438974695cb4177a86b0bb3ada4eeb9d"
    sha256 cellar: :any, catalina:      "e76909c37c8e8bfb04b280d2add1d8d20362edf5d7f5cada2e5054b58e45cc8d"
    sha256 cellar: :any, mojave:        "00c9cd991ef6a8e281e5f97acacc77303e393ee47fbf0f95f3b4e7d73329505d"
  end

  depends_on "graphviz"
  depends_on "qt@5"

  def install
    spec = (ENV.compiler == :clang) ? "macx-clang" : "macx-g++"
    spec << "-arm64" if Hardware::CPU.arm?
    cd "qcachegrind" do
      system "#{Formula["qt@5"].opt_bin}/qmake", "-spec", spec,
                                               "-config", "release"
      system "make"

      on_macos do
        prefix.install "qcachegrind.app"
        bin.install_symlink prefix/"qcachegrind.app/Contents/MacOS/qcachegrind"
      end

      on_linux do
        bin.install "qcachegrind/qcachegrind"
      end
    end
  end
end
