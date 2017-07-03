MYSQL
-------
INSTALL DOCKER
https://docs.docker.com/docker-for-mac/install/

INSTALL Kitematic (Beta) ** Optional
(from docker pull down -> Get Kitematic)

OPEN Terminal and paste
docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=django -d -p 3306:3306 mysql

You should now have a running mysql instance:
    - to restart/stop/start use Kitematic or
        - docker stop mysql
        - docker start mysql
        - docker restart mysql
        
    - to connect to container use Kitematic shell or
        - docker exec -it mysql bash
        

INSTALL CODE (TO BE RUN ONCE) 
--------
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

SET VIRTUAL ENV FOR speweb to point to the 2.x version
pyenv virtualenv 2.7.13 speweb

( from the website directory )
pyenv local speweb
NOTE: will create a .pyenv file that will automatically set the environment when you cd to this direcotry or below


SCRIPTS (TO BE RUN PERIODICALLY)
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
    
    
    
INTEGRATION WITH IDE
----------------------
 - point ide to <home>.env/speweb/ !!! UPDATE LINK !!!
 - point folder to website project folder
 - set the settings and working directory
 - say yes to build from existing sources
 - create a new django run level picking the same settings as above
 - run -> localhost:8000 should show our homepage