echo "Sourcing all the stuff"
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby ruby-1.9.3
source /usr/local/opt/chruby/share/chruby/auto.sh

echo "cd-ing into Shure directory"
cd /Users/efatsi/Desktop/Projects/shure

echo "Running: git checkout $1"
git checkout -b $1; git checkout $1
echo "Running: git pull --rebase origin $1"
git pull --rebase origin $1
echo "Running: git checkout $2"
git checkout -b $2; git checkout $2
echo "Running: git reset --hard $1"
git reset --hard $1
echo "Running: git push origin $2 -f"
git push origin $2 -f
echo "Running: bundle install"
bundle install
echo "Running: bundle exec cap $2 deploy:migrations"
bundle exec cap $2 deploy:migrations
