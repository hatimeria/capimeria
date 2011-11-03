load Gem.find_files('captain.rb').last.to_s

set :shared_files,        ["app/etc/local.xml", "index.php", ".htaccess"]

namespace :loc do
  desc "Local clear cache"
  task :cc do
    clear_cache
    clear_media_cache
  end
  desc "Local main cache clear"
  task :clear_cache do
    run_locally "if [ -d ./var/cache ] ; then rm -rf ./var/cache/*; fi"
  end
  desc "Local media cache clear"
  task :clear_media_cache do
    run_locally "if [ -d ./media/css ] ; then rm -rf ./media/css/*; fi"
    run_locally "if [ -d ./media/js ] ; then rm -rf ./media/js/*; fi"
  end
  desc "Local session clear"
  task :clear_session do
    run_locally "if [ -d ./var/session ] ; then rm -rf ./var/session/*; fi"
  end
end