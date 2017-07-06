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
    

INSTALL CODE (TO BE RUN ONCE) 
--------
INSTALL PV (used to give a % complete on the import)
brew install pv

INSTALL pyenv
brew install pyenv
NOTE: don't forget to set your bash profile with
add to profile: if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

INSTALL pyenv-virtualenv
brew install pyenv-virtualenv
NOTE: don't forget to set your bash profile with
add to profile: if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

INSTALL latest 2.x version of python
pyenv install 2.7.13

[OPTIONALLY] install latest 3.x version of python
pyenv install 3.6.1
00.

SET VIRTUAL ENV FOR speweb to point to the 2.x version
pyenv virtualenv 2.7.13 speweb

LOAD CODE: run ./sync-code.sh  (creates the website folder with all code)

( from the website directory )
pyenv local speweb
NOTE: will create a .pyenv file that will automatically set the environment when you cd to this direcotry or below


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
 - point ide to <home>.env/speweb/ !!! UPDATE LINK !!!
 - point working folder to website/mainsite project folder (<installdir>/web/website/mainsite)
 - set the settings file (<installdir>/web/website/mainsite/settings/local)
 - say yes to build from existing sources
 - create a new django run level picking the same settings as above
 - run -> localhost:8000 should show our homepage