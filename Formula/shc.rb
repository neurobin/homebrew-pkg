class Shc < Formula
  desc "Shell script compiler"
  homepage "https://neurobin.org/projects/softwares/unix/shc/"
  url "https://github.com/neurobin/shc/archive/4.0.1.tar.gz"
  version "4.0.1"
  sha256 "494666df8b28069a7d73b89f79919bdc04e929a176746c98c3544a639978ba52"

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
