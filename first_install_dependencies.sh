# Installing Laravel and Bower dependencies
ROOT_DIR=$PWD
npm install --cache-min 999999
bower install
# build knockoutjs file
cd $ROOT_DIR/assets/vendor/knockoutjs
grunt clean checktrailingspaces build:debug test:phantomjs
# build file structure
cd $ROOT_DIR/assets/my/less
## reads variables.less (from Bootstrap directory), change path names and save to current directory
sed 's|"../fonts/"|"/assets/vendor/bootstrap/fonts/"|g' $ROOT_DIR/assets/vendor/bootstrap/less/variables.less > variables.less 
## reads bootstrap.less (from Bootstrap directory), change path names, except with the line 'variables' and save to current directory
sed '/variables/!s|@import "|@import "../../vendor/bootstrap/less/|g' $ROOT_DIR/assets/vendor/bootstrap/less/bootstrap.less > bootstrap.less

# return directory
cd $ROOT_DIR

grunt less concat uglify
echo "DONE task"
# remove git origin
git remote remove origin
# remove 4 lines end of this file
cat first_install_dependencies.sh | tail -r | tail -n +4 | tail -r > first_install_dependencies.sh