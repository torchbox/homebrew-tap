class Buckup < Formula
  include Language::Python::Virtualenv

  desc "Creating S3 buckets for your site with ease."
  homepage "https://github.com/torchbox/buckup"
  url "https://github.com/torchbox/buckup/archive/v0.1a5.tar.gz"
  sha256 "b413742d28b6f365df4028858b6078c91850bf18793c00e0a9dab0c3da44d989"
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
