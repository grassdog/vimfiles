
desc "Link rc files"
task :link do
  sh "ln -s ~/.vim/vimrc ~/.vimrc"
  sh "ln -s ~/.vim/gvimrc ~/.gvimrc"
end

desc "Pull all submodules"
task :init do
  sh "git pull"
  sh "git submodule init"
  sh "git submodule update"
end

desc "Update all submodules"
task :update do
  sh "git submodule foreach git pull origin master"
end

desc "Create tmp directory"
task :create_temp do
  sh 'mkdir -p ~/.vim/tmp/undo'
end

task :setup => [:init, :create_temp]
