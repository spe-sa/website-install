These instructions are intended to get a development environment set up and running for the SPE website project on OSX.  For other OS's please insert instructions later per OS when needed.

cd to install directory: ie, ~/dev/projects/spe
CLONE THIS CODE TO YOUR NEW PROJECT DIRECTORY
git clone https://github.com/spe-sa/website-install.git django

MYSQL
-------
INSTALL MYSQL CLIENT for scripts (if you don't already have a client)
========
brew install mysql 
- restart the terminal by choosing Terminal -> Quit from menu bar
brew services list
NOTE: for auto startup
brew services start mysql
mysql -u root -v
alter user 'root'@'localhost' identified by 'root';
exit
NOTE: if you get a warning or error about upgrading run: sudo mysql_upgrade
    

INSTALL CODE (TO BE RUN ONCE) 
--------
INSTALL PV (used to give a % complete on the import)
brew install pv

INSTALL pyenv
brew install pyenv
NOTE: don't forget to set your bash profile with
- add to profile: if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

INSTALL pyenv-virtualenv
brew install pyenv-virtualenv
NOTE: don't forget to set your bash profile with
- add to profile: if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

INSTALL latest 2.x version of python
pyenv install 2.7.13

[OPTIONALLY] install latest 3.x version of python
pyenv install 3.6.1
00.

SET GLOBAL ENV FOR TERMINAL IF NOT OVERRIDDEN
pyenv global 2.7.13

SET VIRTUAL ENV FOR speweb to point to the 2.x version
pyenv virtualenv 2.7.13 speweb

LOAD CODE: run ./sync-code.sh  (creates the website folder with all code)

( from the website directory )
pyenv local speweb
NOTE: will create a .pyenv file that will automatically set the environment when you cd to this direcotry or below
- add to profile: export DJANGO_SETTINGS_MODULE=mainsite.settings.local
NOTE: if you have other django projects that use the default settings location you may need to comment this or manually execute in the terminal


SCRIPTS (TO BE RUN PERIODICALLY) - The first time will set up; later will refresh. RUN EACH ONCE TO START WITH
--------

sync-code.sh
    - clones website if doesn't exist and pulls code
    - simply pulls and merges code if dir exists
    - sync-code.sh -f forces directory removal and does a new clone
        
sync-db.sh
    - pulls the latest jenkins backup locally vis scp
    - deletes and recreates the django database from backup files
    
sync-files.sh
    - rsyncs files from production (only one copy with deltas)
    
    
NOTE: DO NOT PLACE THESE IN YOUR PATH.  I am using relative paths and the scripts expect to be run from the scripts folder.
    
INTEGRATION WITH IDE
----------------------
 - point ide to <home>/.pyenv/speweb/ or .../speweb/
 - point working folder to website/mainsite project folder (<installdir>/website/mainsite)
 - set the settings file (<installdir>/website/mainsite/settings/local)
 - say yes to build from existing sources
 - click the wrench or go to project properties
    - under languages and frameworks choose Django
        - enable django support
        - set project to <install dir>/website (ex: /Users/sstacha/dev/projects/spe/django/website)
        - set settings to mainsite/settings/local.py
        - should automatically set manage.py for manage script
    - under build, execucution, deployment
        - under Console choose Python Console
            - set working directory (ex: /Users/sstacha/dev/projects/spe/django/website)
            - set environment variable DJANGO_SETTINGS_MODULE to mainsite.settings.local
                - NOTE: should look like this when done: DJANGO_SETTINGS_MODULE=mainsite.settings.local
            - check add source roots to have them autoload
        - under Console choose Django Console
            - set working direcotry (ex: /Users/sstacha/dev/projects/spe/django/website)
            - set environment variable DJANGO_SETTINGS_MODULE to mainsite.settings.local
                - NOTE: should look like this when done: DJANGO_SETTINGS_MODULE=mainsite.settings.local
            - check add source roots to have them autoload
 - drop down the empty dropdown and choose run configurations
    - click the + and select django server
    - name it localhost (or whatever you like)
    - set working directory
    - leave everything else default
 - run -> localhost:8000 should show our homepage
 
 NOTE: if you see a msg about migrations to apply then open terminal and run ./makemigrations and ./migrate
