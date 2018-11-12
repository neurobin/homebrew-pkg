class Shc < Formula
  desc "Shell script compiler"
  homepage "https://neurobin.org/projects/softwares/unix/shc/"
  url "https://github.com/neurobin/shc/archive/3.9.8.tar.gz"
  version "3.9.8"
  sha256 "8b31e1f2ceef3404217b9578fa250a8a424f3eaf03359dd7951cd635c889ad79"

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
