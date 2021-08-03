import sys
from charms.reactive import when_not, when, set_flag
from subprocess import Popen, PIPE
from charmhelpers.core import hookenv

@when('apt.installed.npm')
@when_not('nodered.installed')
def install_nodered():
    configs = hookenv.config()
    port = configs.get('port')
    title = configs.get('title')
    storage_id = hookenv.storage_list('app')[0]
    storage = hookenv.storage_get('location', storage_id)

    run('curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash')
    run('npm install -g --unsafe-perm node-red')
    cmd = 'nohup sudo node-red -p {} --safe -u {} --title {} &>/dev/null &'.format(port,storage,title)    
    run(cmd, sync = False)
    hookenv.open_port(port)
    hookenv.log('Opened port {}'.format(port))
    set_flag('nodered.installed')
    hookenv.status_set('active','Ready')

@when('website.available')
def configure_website(website):
    configs = hookenv.config()
    website.configure(port=configs.get('port'))

def run(cmd, sync=True):
    hookenv.status_set(
        'maintenance',cmd)
    if sync:
        with Popen(cmd,shell=True,stderr=PIPE) as process:
            _, errout = process.communicate()
            retcode = process.poll()
    else:
        with Popen(cmd,shell=True,stdin=None, stdout=None, stderr=None,close_fds=True) as process:
            _, errout = process.communicate()
            retcode = 0
    if retcode != 0:
        hookenv.log('run error: {}'.format(errout))
        hookenv.status_set("blocked", "run error: {}".format(errout))
        sys.exit(0)
    hookenv.status_set('maintenance','done')
