
desc 'Link rc files'
task :link_rc_files do
  %w[ vimrc ].each do |file|
    dest = File.expand_path("~/.#{file}")
    unless File.exist?(dest)
      ln_s(File.expand_path("../#{file}", __FILE__), dest)
    end
  end
end

desc 'Install plugins via Vundle'
task :install do
  sh 'vim +BundleInstall +qall'
end

desc 'Create tmp directories'
task :create_temp do
  sh 'mkdir -p ~/.vim/tmp/undo'
  sh 'mkdir -p ~/.vim/tmp/backups'
end

desc 'Setup a new installation'
task :setup => [:create_temp, :link_rc_files, :install]
