load Gem.find_files('capimeria.rb').last.to_s

set :atimeria_extjs, false

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
  namespace :assets do
      desc "Updates assets version"
      task :update_version do
          run "sed -i 's/\\(assets_version:\\)\\(.*\\)$/\\1 #{real_revision}/g' #{latest_release}/app/config/config.yml"
      end
  end
  namespace :vendors do
      desc "Selects vendors script mode"
      task :update do
          #if !exists?("vendors_mode")
          #  set :vendors_mode, "hatimeria"
          #end
          vendors_mode.chomp
          case vendors_mode
            when "full" then full
            when "hatimeria" then hatimeria
            else p "None vendors mode selected"
          end
      end
      desc "Runs the bin/vendors script to update fully vendors"
      task :full do
          run "cd #{latest_release} && #{php_bin} bin/vendors install"
      end
      desc "Runs the bin/vendors script with hatimeria option"
      task :hatimeria do
          run "cd #{latest_release} && #{php_bin} bin/vendors install -h"
      end
  end
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
  namespace :extjs do
      desc "Install extjs library into ExtJSBundle"
      task :install do
        run "cd #{latest_release} && #{php_bin} #{symfony_console} hatimeria:extjs:install --env=#{symfony_env_prod}"
      end
      desc "Compile extjs classes"
      task :compile do
        run "cd #{latest_release} && #{php_bin} #{symfony_console} hatimeria:extjs:compile --env=#{symfony_env_prod}"
      end
  end
end

before "symfony:assets:install" do
    if hatimeria_extjs
        symfony.extjs.install
    end
end

after "symfony:assets:install" do
    if hatimeria_extjs
        symfony.extjs.compile
    end
    symfony.assets.update_version
end
