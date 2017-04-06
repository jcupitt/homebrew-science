class Nip2 < Formula
  desc "GUI for the VIPS image processing system"
  homepage "https://github.com/jcupitt/nip2"
  url "https://github.com/jcupitt/nip2/releases/download/v8.5.1/nip2-8.5.1.tar.gz"
  sha256 "8a3d277ae59f880b4075d8a0d4fe081e99605cbfb22f3647dafce9e24dbeb9f3"

  bottle do
    cellar :any
    sha256 "e0af078a5d9786c71077ed55dd415e978d144c0ba2016cc61fdea009b62eaa74" => :sierra
    sha256 "2333489eaae68a285287ea418de1445bcd4cc7bdc758b8cbf260f99e25e0d7b0" => :el_capitan
    sha256 "073238e0e5b4d984e66f8eedd3b458d553e16edf047eb6696ae1fd752d68e0a8" => :yosemite
  end

  option "with-test", "Enable build-time testing"
  deprecated_option "with-check" => "with-test"

  depends_on "pkg-config" => :build
  depends_on "XML::Parser" => :perl
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+"
  depends_on "vips"

  depends_on "fftw" => :recommended
  depends_on "gsl" => :recommended
  depends_on "goffice" => :recommended
  depends_on "libgsf" => :recommended

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    system "./configure", *args
    system "make", "check" if build.with? "check"
    system "make", "install"
  end

  test do
    # when first run, nip2 tries to create ~/Library/nip2-x.y.z
    # to hold temp files ... ~/Library is not present in homebrew's
    # private test home directory
    require "fileutils"
    mkdir_p ENV["HOME"] + "/Library"

    system "#{bin}/nip2", "--benchmark"
  end
end
