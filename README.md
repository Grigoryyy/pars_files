<h1>Скрипт для поиска 10 самых больших по размеру файлов в системе (Windows/Linux)</h1>

<h3>Принимает на вход 2 параметра -InputDirectory и -OutputDirectory. Скрипт найдет все файлы в InputDirectory и поддиректориях и составить отчет в формате .txt, содержащий топ 10 самых больших типов файлов по расширению, сортированный по убыванию суммарного размера.</h3>

<h5>Запуск - ./pf.ps1

Чтобы скрипт запустился в Linux (Ubuntu) необходимо выполнить команды:

- Update the list of packages

sudo apt-get update
- Install pre-requisite packages.

sudo apt-get install -y wget apt-transport-https software-properties-common
- Download the Microsoft repository GPG keys

wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
- Register the Microsoft repository GPG keys

sudo dpkg -i packages-microsoft-prod.deb
- Delete the the Microsoft repository GPG keys file

rm packages-microsoft-prod.deb
- Update the list of packages after we added packages.microsoft.com

sudo apt-get update
- Install PowerShell

sudo apt-get install -y powershell
- Start PowerShell

pwsh
</h5>