class HerokuAudit < Formula
  include Language::Python::Virtualenv

  desc "Command-line tool for reporting on specific attributes of a Heroku environment."
  homepage "https://github.com/torchbox/heroku-audit"
  url "https://github.com/torchbox/heroku-audit/archive/0.0.2.tar.gz"
  sha256 "0c539746c4b5dfb1ff8504e1a96394c3456666c866e0f0c1f7f54ef6f1242279"
  head "https://github.com/torchbox/heroku-audit.git"

  depends_on "python@3"

  def install
    if Language::Python.major_minor_version("python3") >= "3.12"
      # `without_pip` is replaced with `ensurepip` in python 3.12+
      venv = virtualenv_create(libexec, "python3")
      system libexec/"bin/python", "-m", "ensurepip"
    else
      venv = virtualenv_create(libexec, "python3", without_pip: false)
    end
    system libexec/"bin/python", "-m", "pip", "install", buildpath
    system libexec/"bin/python", "-m", "pip", "uninstall", "-y", "heroku-audit"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_predicate bin/"heroku-audit", :exist?
    # TODO: Re-add this once https://github.com/torchbox/heroku-audit/issues/5 is fixed
    # system bin/"heroku-audit", "--list"
    # assert_match "Heroku Audit v#{version}", shell_output("#{bin}/heroku-audit --version")
  end
end
