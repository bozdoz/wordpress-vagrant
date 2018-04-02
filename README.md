# WordPress Vagrant

A Vagrant test environment for WordPress

## Pre-requisites

- Vagrant [https://www.vagrantup.com/](https://www.vagrantup.com/)
- Vagrant Plugin hostsupdater [https://github.com/cogitatio/vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)
- Virtualbox [https://www.virtualbox.org/](https://www.virtualbox.org/)

## Installation:

1. **Clone the repo:**
    ```shell
    git clone git@github.com:bozdoz/wordpress-vagrant.git your-site-name
    ```
2. **Enter the new directory**
    ```shell
    cd your-site-name
    ```
3. **(recommended) Remove .git (start your own repo)**
    ```shell
    sudo -R .git
    ```
4. **Run Vagrant**
    ```
    npm run up
    ```
5. **(Optional) Run NPM Install**
    ```shell
    npm install
    ```
6. **(Optional) Alter gulp variables as needed**
    The theme directory in `gulpfile.js` assumes you will be altering a theme; you will need to provide this theme directory name in order to use [browser-sync](https://www.browsersync.io/).
    ```shell
    npm start
    ```
7. **What Else Would You Want To Do Next?**

## Variables
**Vagrant** (./vagrant/Vagrantfile) assumes that you want to launch a site at `local.directory-name.com`, and will try to update your `hosts` file to redirect that URL to your virtualbox.  You can obviously alter the `HOSTNAME` variable in Vagrantfile to change this.

**Gulp** and **.gitignore** (if you're on a repo) include `your-theme-name` in 1 and 2 places, respectively.  Alter these to update the theme that you may intend to work on. 