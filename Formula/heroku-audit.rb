class HerokuAudit < Formula
  include Language::Python::Virtualenv

  desc "Command-line tool for reporting on specific attributes of a Heroku environment."
  homepage "https://github.com/torchbox/heroku-audit"
  url "https://github.com/torchbox/heroku-audit/archive/0.0.0.tar.gz"
  sha256 "bc57832d67be1bc24c03ed58d4de98556ab859e7b7ba5c5f634688a9fbd94021"
  head "https://github.com/torchbox/heroku-audit.git"

  depends_on "python@3"

  def install
    venv = virtualenv_create(libexec, "python3", without_pip: false)
    system libexec/"bin/pip", "install", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "heroku-audit"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_predicate bin/"heroku-audit", :exist?
    assert_match "Heroku Audit v#{version}", shell_output("#{bin}/heroku-audit --version")
  end
end
