# iac-nextcloud

Receita para o Nextcloud 

## Dependencias

Instalação do gerenciador de bibliotecas Pip e do ambiente virtual

~~~bash
apt install python3-pip python3-venv
~~~

Antes de instalar o ansible, criar o ambiente virtual:

~~~bash
python -m venv .venv
~~~

Entrar no Ambiente Virtual

~~~bash
source .venv/bin/activate  
~~~

Instalar as dependência do python 

~~~bash
pip install --upgrade pip
pip install -r requirements.txt
~~~

Exportar a variavel do arquivo de configuração do ansible

~~~bash
export ANSIBLE_CONFIG=$(PWD)/ansible.cfg
~~~

Criar um certificado pro apache2

~~~bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./config_nc_web/files/ssl/ollemg.br.key -out ./config_nc_web/files/ssl/ollemg.br.crt
~~~

Alterar o usuario que ira conectar no servidor no arquivo ansible.cfg

OBS: o usuario tem que ter permissões de sudo

~~~bash
[defaults]
ask_pass                = True
host_key_checking       = False
timeout                 = 300
inventory               = ./hosts.ini
deprecation_warnings    = False
remote_user             = {USERNAME}
~~~

Mudar o IP do servidor em hosts.ini

~~~bash
[web]
172.30.3.241

[db]
172.30.3.242
~~~

Executar o playbook

~~~bash
ansible-playbook playbook.yaml
~~~