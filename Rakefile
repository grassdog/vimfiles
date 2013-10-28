
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
task :create_temp_dirs do
  %w{undo backups sessions swaps}.each do |dir|
    sh "mkdir -p ~/.vim/tmp/#{dir}"
  end
end

desc 'Setup a new installation'
task :setup => [:create_temp_dirs, :link_rc_files, :install]
