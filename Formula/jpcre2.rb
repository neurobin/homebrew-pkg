class Jpcre2 < Formula
  desc "C++ wrapper for PCRE2 Library"
  homepage "http://docs.neurobin.org/jpcre2"
  url "https://github.com/jpcre2/jpcre2/archive/10.31.02-1.tar.gz"
  sha256 "7228059ea1c72d9d4ff340c417bb4715dcbce23f79c6ed370bd3d1761826ef4a"
  # depends_on "cmake" => :build
  depends_on "pcre2"
  version "10.31.02"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          #"--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    test_cpp_file = testpath/"test.cpp"
    test_cpp_file.write <<~EOS
        #include <iostream>
        #include "jpcre2.hpp"
        typedef jpcre2::select<char> jp;
        
        int main(){
            std::cout<<jp::Regex("\\d").match("123456789", "g"); //will print 9
            return 0;
        }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++1y", "-L#{lib}", "-lpcre2-8", "-o", "test"
    output = shell_output("test").strip()
    assert_match "9", output
  end
end
