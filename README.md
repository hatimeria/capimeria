Capimeria
===

## Wymagania ##

- Ruby
- RubyGems

## Instalacja ##

### Poprzez RubyGemsorg ###

    sudo gem install capimeria
    
### Poprzez GitHub ###

    git clone git@github.com:hatimeria/capimeria.git
    cd capimeria
    gem build capimeria.gemspec
    sudo gem install capimeria-{version}.gem
    
## Wlaczenie capimeri w projekcie ##

Wchodzimy do katalogu z projektem i wywolujemy komende:

    capimeria .
    
W celu uzyskania wiekszej ilosci opcji:

    capimeria . -h
    
W zaleznosci od typu projektu (symfony 1/Symfony2/Magento) zostana utworzone pliki:

- Capfile w glownym katalogu projektu
- deploy.rb w katalogu konfiguracyjnym:
  - magento: app/etc/
  - symfony 1: config/
  - Symfony2: app/config/
- jesli konfiguracja zostala odpalona wraz z multistagem (defaultowo sa tworzone dwa stage prod oraz dev)
  zostanie dodany katalog deploy do wyzej wymienionych wraz z plikami stagow np. app/config/deploy/prod.rb

## Wprowadzamy konfiguracje ##

Pliki ktore trzeba przygotowac dla projektu to deploy.rb oraz jesli uzywamy multistage to wszystkie pliki multistage.

### Dostepne opcje konfiguracyjne ###

## Deployment ##

Jednorazowo wywolujemy komende po skonfigurowaniu:

    cap deploy:setup
    
Nastepnie aby wrzucic ostatnia wersje projektu:

    cap deploy
    
## Dodatki ##

Wypisanie dostepny komand capistrano

    cap -T
    
Wywolanie komendy symfony na serwerze

    cap symfony
