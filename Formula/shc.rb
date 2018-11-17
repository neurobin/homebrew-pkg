class Shc < Formula
  desc "Shell script compiler"
  homepage "https://neurobin.org/projects/softwares/unix/shc/"
  url "https://github.com/neurobin/shc/archive/4.0.0.tar.gz"
  version "4.0.0"
  sha256 "750f84441c45bd589acc3b0f0f71363b0001818156be035da048e1c2f8d6d76b"

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
