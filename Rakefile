
desc "Link rc files"
task :link_rc_files do
  %w[ vimrc ].each do |file|
    dest = File.expand_path("~/.#{file}")
    unless File.exist?(dest)
      ln_s(File.expand_path("../#{file}", __FILE__), dest)
    end
  end
end

desc "Initialise and pull all commited version of submodules"
task :init do
  sh "git pull"
  sh "git submodule init"
  sh "git submodule update"
end

desc "Update all submodules to their latest commits"
task :update do
  sh "git submodule foreach git pull origin master"
end

desc "Create tmp directories"
task :create_temp do
  sh 'mkdir -p ~/.vim/tmp/undo'
  sh 'mkdir -p ~/.vim/tmp/backups'
end

desc "Setup a new installation"
task :setup => [:init, :create_temp, :link_rc_files]
