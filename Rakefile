desc 'Link rc files'
task :link_rc_files do
  dest = File.expand_path("~/.vim")
  ln_s(Dir.pwd, dest) unless File.exist?(dest)

  dest = File.expand_path("~/.vimrc")
  ln_s(File.expand_path("../vimrc", __FILE__), dest) unless File.exist?(dest)
end

desc 'Install plugins via Vundle'
task :install do
  sh 'vim +BundleInstall +qall'
end

desc 'Create tmp directories'
task :create_temp_dirs do
  %w{undo backups sessions swaps}.each do |dir|
    sh "mkdir -p tmp/#{dir}"
  end
end

desc 'Setup a new installation'
task :setup => [:create_temp_dirs, :link_rc_files, :install]
