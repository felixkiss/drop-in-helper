set_default :ruby_version, "1.9.3-p385"
# set_default :rbenv_bootstrap, "bootstrap-ubuntu-12-04"

namespace :rbenv do
	desc "Install rbenv, Ruby, and the bundler gem"
	task :install, roles: :app do
		run "#{sudo} apt-get -y install curl git-core"
		run "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"
		bashrc = <<-BASHRC
if [ -d $HOME/.rbenv ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi
BASHRC
		put bashrc, "/tmp/rbenvrc"
		run "cat /tmp/rbenvrc ~/.zshrc > ~/.zshrc.tmp"
		run "mv ~/.zshrc.tmp ~/.zshrc"
		run %q{export PATH="$HOME/.rbenv/bin:$PATH"}
		run %q{eval "$(rbenv init -)"}

		# run "rbenv #{rbenv_bootstrap}"
		# Manual bootstrap for ubuntu 12.04
		run "#{sudo} apt-get -y install build-essential tklib zlib1g-dev libssl-dev libreadline-gplv2-dev libxml2 libxml2-dev libxslt1-dev"

		run "rbenv install --force #{ruby_version}"
		run "rbenv global #{ruby_version}"
		run "gem install bundler --no-ri --no-rdoc"
		run "rbenv rehash"
	end
	after "deploy:install", "rbenv:install"
end