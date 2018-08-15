class Jpcre2 < Formula
  desc "C++ wrapper for PCRE2 Library"
  homepage "http://docs.neurobin.org/jpcre2"
  url "https://github.com/jpcre2/jpcre2/archive/10.31.02-1.tar.gz"
  sha256 "7228059ea1c72d9d4ff340c417bb4715dcbce23f79c6ed370bd3d1761826ef4a"
  # depends_on "cmake" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test jpcre2`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
