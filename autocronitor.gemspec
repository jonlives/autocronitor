$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'autocronitor'
  gem.version       = '0.0.1'
  gem.authors       = ["Jon Cowie"]
  gem.email         = 'jonlives@gmail.com'
  gem.homepage      = 'https://github.com/jonlives/autocronitor'
  gem.licenses      = ['MIT']
  gem.summary       = "A tool to automatically pass a standard-format crontab file and add jobs to cronitor.io for monitoring"
  gem.description   = "A CLI tool to parse a standard format crontab file, create monitors in cronitor.io for each job, and automatically add the necessary curl commands to the original crontab. It assumes that you are using cronitor's 'template' feature to configure notifications for your monitors, and that you have created templates which will then be passed to autocronitor. Please note, cronitor.io (and therefore autocronitor) do not support 'informal' cron expressions such as @hourly or @daily."

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'unirest', '~> 1.1', '>= 1.1.2'
  gem.add_runtime_dependency 'choice', '~> 0.2', '>= 0.2.0'
end