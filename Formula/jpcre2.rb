class Jpcre2 < Formula
  desc "C++ wrapper for PCRE2 Library"
  homepage "http://docs.neurobin.org/jpcre2"
  url "https://github.com/jpcre2/jpcre2/archive/10.32.01.tar.gz"
  sha256 "e8c69a6a6f77ed8d5c35dcdfa767b155f5230a83f55d35cab837b6f0a1266ca8"
  depends_on "pcre2"
  version "10.32.01"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          #"--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    test_cpp_file = testpath/"test.cpp"
    test_cpp_file.write <<~EOS
        #include <iostream>
        #include "jpcre2.hpp"
        typedef jpcre2::select<char> jp;
        
        int main(){
            std::cout<<jp::Regex("\\\\d").match("123456789", "g"); //will print 9
            return 0;
        }
    EOS
    system ENV.cxx, test_cpp_file, "-std=c++1y", "-lpcre2-8", "-o", "test"
    output = shell_output("./test").strip()
    assert_equal "9", output
  end
end
