class Buckup < Formula
  include Language::Python::Virtualenv

  desc "Creating S3 buckets for your site with ease."
  homepage "https://github.com/torchbox/buckup"
  url "https://github.com/torchbox/buckup/archive/v0.1a7.tar.gz"
  sha256 "b914dfeafd9472f01d18b8b85f26756f8fe981bfa8dc0cbf9812dcd82848780f"
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
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_predicate bin/"buckup", :exist?
  end
end
