
Test the connection:

~~~
ansible -i ./hosts_staging staging -m ping
~~~

Run the playbook over the host:
(install server)
~~~
ansible-playbook -i ./hosts_staging install_server.yml
~~~
(copy asesora site)
(backup)
(restore)
(drop)


# Older and not used:

Vagrant provision automate (not needed):

~~~
config.vm.provision "ansible" do |ansible|
  ansible.verbose = "v"
  ansible.playbook = "configure_server.yml"
end
~~~
