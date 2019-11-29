class Rnm < Formula
  desc "Unix tool: Bulk Rename Utility"
  homepage "https://neurobin.org/projects/softwares/unix/rnm/"
  url "https://github.com/neurobin/rnm/archive/4.0.7.tar.gz"
  version "4.0.7"
  sha256 "3e95d00cbb84a505cec5706abb946fc19412985ff1ece9b453db53dea8d77a9f"
  depends_on "jpcre2" => :build
  depends_on "gmp"
  depends_on "pcre2"

  def install
    ENV.cxx11
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "CXX=g++",
                          
    system "make"
    system "make", "install"
  end

  test do
    shell_output("mkdir testdir; for f in $(seq 1 4000); do touch testdir/$f; done")
    output = shell_output("#{bin}/rnm -y -rs '//fn///fn/@ B16: /idr-b16/ L: /idr-l/ S: /idr-s/ mtime:/info-mtime-%d-%m-%Y %H:%I %p//' -fo -dp -1 -s ./testdir").strip
    assert_match "4000", output
  end
end
