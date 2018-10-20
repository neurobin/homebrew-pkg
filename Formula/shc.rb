class Shc < Formula
  desc "Shell script compiler"
  homepage "https://neurobin.org/projects/softwares/unix/shc/"
  url "https://github.com/neurobin/shc/archive/3.9.8.tar.gz"
  version "3.9.6"
  sha256 "12e82886406d3c9ab30fa1a47468c239cea398a0d629c73fe6d438b8fcd5ba1e"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    test_file = testpath/"test.sh"
    test_file.write <<~EOS
        #!/bin/sh
        echo hello
    EOS
    system "#{bin}/shc", "-f", test_file, "-o", "test"
    assert_equal "hello", shell_output("./test").strip
  end
end
