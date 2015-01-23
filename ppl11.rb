require 'formula'

class Ppl11 < Formula
  homepage 'http://bugseng.com/products/ppl/'
  url 'http://bugseng.com/products/ppl/download/ftp/releases/1.1/ppl-1.1.tar.gz'
  sha1 'd24c79f7299320e6a344711aaec74bd2d5015b15'

  if OS.linux?
  else
    depends_on 'homebrew/dupes/m4' => :build if MacOS.version < :leopard
  end
  depends_on 'gmp'

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --with-gmp=#{Formula.factory('gmp').opt_prefix}
    ]
    if OS.linux?
        args << "--disable-shared"
        args << "--host=core2-unknown-linux-gnu"
        args << "--build=core2-unknown-linux-gnu"
        args << "--disable-ppl_lpsol"
        args << "--disable-ppl_lcdd"
    end
    system "./configure", *args
    system "make install"
  end
end
