#
# Cookbook Name:: dev-endorno
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'zsh' do
  action :install
end

package 'vim' do
  action :install
end

user_name = node["user"]["develop"]
home_directory = "/home/"+user_name

git home_directory+'/dotfiles' do
  user user_name
  group user_name
  repository  "git://github.com/endorno/dotfiles.git"
  reference "master"
  action :sync
#  enable_submodules true
end

dotfiles = [".vimrc", ".zshrc", ".vim" ]
dotfiles.each do |f|
  link home_directory+"/"+f do
    to home_directory+"/dotfiles/"+f
    link_type :symbolic
  end
end

bash "change default shell" do
  user user_name
  code <<-EOL
  chsh -s `which zsh`
  EOL
end

