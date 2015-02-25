class Nip2 < Formula
  homepage "http://www.vips.ecs.soton.ac.uk/"
  url "http://www.vips.ecs.soton.ac.uk/supported/7.42/nip2-7.42.1.tar.gz"
  sha1 "46e48e003621c5c63a5bf0e126f7ace0c0b54746"

  option "with-check", "Enable build-time checking"

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+"
  depends_on "libxml2"
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
    system "#{bin}/nip2", "--benchmark" 
  end
end
