load Gem.find_files('captain.rb').last.to_s

# overwritting capistratno and capifony deployment procedures
namespace :deploy do
  namespace :web do
    desc "Disabling web directory"
    task :disable, :roles => :web do
      on_rollback { rm "#{shared_path}/web/system/maintenance.html" }

      maintenance_file = "./app/Resources/maintenance.html"
      if File.exists?(maintenance_file)
        maintenance = File.read("./app/Resources/maintenance.html")
      else
        maintenance = 'Przerwa techniczna'
      end

      put maintenance, "#{shared_path}/web/system/maintenance.html", :mode => 0644
    end
    desc "Enabling web directory"
    task :enable, :roles => :web, :except => { :no_release => true } do
      run "rm #{shared_path}/web/system/#{maintenance_basename}.html"
    end
  end
end

namespace :symfony do
  # remove after nice user will deploy application not f-in root!!
  namespace :cache do
    desc "Clears project cache."
    task :clear do
      run "cd #{latest_release} && #{php_bin} #{symfony_console} cache:clear --env=#{symfony_env_prod}"
      run "chmod -R 777 #{latest_release}/#{cache_path}"
    end
    desc "Warms up an empty cache."
    task :warmup do
      run "cd #{latest_release} && #{php_bin} #{symfony_console} cache:warmup --env=#{symfony_env_prod}"
      run "chmod -R 777 #{latest_release}/#{cache_path}"
    end
  end
end