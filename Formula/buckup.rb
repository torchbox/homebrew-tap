class Buckup < Formula
  include Language::Python::Virtualenv

  desc "Creating S3 buckets for your site with ease."
  homepage "https://github.com/torchbox/buckup"
  url "https://github.com/torchbox/buckup/archive/v0.1a4.tar.gz"
  sha256 "e58c0a027ad7fe06dbe1932c9989d62a42cbebf6bff58e88cb6dfdbd27d63a90"
  head "https://github.com/torchbox/buckup.git"

  depends_on "python@3"

  def install
    venv  = virtualenv_create(libexec, "python3")
    system libexec/"bin/pip", "install", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "buckup"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_predicate bin/"buckup", :exist?
  end
end
