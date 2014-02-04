require 'formula'

class Vips < Formula
  homepage 'http://www.vips.ecs.soton.ac.uk/'
  url 'http://www.vips.ecs.soton.ac.uk/supported/7.38/vips-7.38.3.tar.gz'
  sha1 '9a9bad342d0c85182419c82f7aaabc16df1be130'

  option 'without-check', 'Disable build time checks (not recommended)'

  depends_on 'pkg-config' => :build
  depends_on :fontconfig
  depends_on 'gettext'
  depends_on 'glib'
  depends_on :libpng => :optional
  depends_on 'jpeg' => :optional
  depends_on 'orc' => :optional
  depends_on 'openslide' => :optional
  depends_on 'libtiff' => :optional
  depends_on 'imagemagick' => :optional
  depends_on 'graphicsmagick' => :optional
  depends_on 'fftw' => :optional
  depends_on 'little-cms' => :optional
  depends_on 'pango' => :optional
  depends_on 'libexif' => :optional
  depends_on 'openexr' => :optional
  depends_on 'cfitsio' => :optional
  depends_on 'webp' => :optional

  def install
    args = [ "--disable-dependency-tracking",
             "--prefix=#{prefix}"]

    args.concat ['--with-magick', '--with-magickpackage=GraphicsMagick'] if build.with? 'graphicsmagick'
    system "./configure", *args
    system 'make', 'check' if build.with? 'check'
    system 'make', 'install'
  end
end
