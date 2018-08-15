class Shc < Formula
  desc "Shell script compiler"
  homepage "https://neurobin.org/projects/softwares/unix/shc/"
  url "https://github.com/neurobin/shc/archive/3.9.6.tar.gz"
  version "3.9.6"
  sha256 "da6a2a3ff4c356a61e086c616561bf681489993cab00c426bad0cfd703a68063"

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
