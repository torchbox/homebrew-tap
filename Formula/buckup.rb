class Buckup < Formula
  include Language::Python::Virtualenv

  desc "Creating S3 buckets for your site with ease."
  homepage "https://github.com/torchbox/buckup"
  url "https://github.com/torchbox/buckup/archive/v0.2.tar.gz"
  sha256 "678acaeead5214002caa05dbc61b5a75a4a8271a8c1062cc8d2245da35c7712b"
  head "https://github.com/torchbox/buckup.git"

  depends_on "python@3"

  def install
    # without_pip is deprecated in python 3.12+, so we only pass it for older versions
    if Language::Python.major_minor_version("python3") >= "3.12"
      venv = virtualenv_create(libexec, "python3")
      system libexec/"bin/python", "-m", "ensurepip"
    else
      venv = virtualenv_create(libexec, "python3", without_pip: false)
    end
    system libexec/"bin/python", "-m", "pip", "install", buildpath
    system libexec/"bin/python", "-m", "pip", "uninstall", "-y", "buckup"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_predicate bin/"buckup", :exist?
  end
end
