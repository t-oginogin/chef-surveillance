For Ubuntu 14.04 LTS 64bit

repipe取得

git clone https://github.com/t-oginogin/chef-surveillance.git ~/chef-surveillance

lohalhost.json内のパラメータ（user,passwordなど）を適宜変更

solo.rb内のcookbook_pathを適宜変更

recipe実行

sudo chef-solo -c solo.rb -j ./localhost.json
