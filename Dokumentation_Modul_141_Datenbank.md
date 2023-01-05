Dokumentation Modul 141 Datenbank 







![mysql reddit](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.001.png)








Autor: 			David Reymond, Paulo Lalicata, Noah Isenschmid, Simeon Aeberli

Ort: 			Berufsfachschule Gibb IET Bern

Lehrperson: 		Herr Beutler Gerhard
# Inhaltsverzeichnis
[1.0	Einleitung	3](#_Toc123842295)

[2.0 Übersicht Systeme	3](#_Toc123842296)

[2.1 Linux Server (vmLS5)	3](#_Toc123842297)

[2.2 Windows Client (vmWP1)	3](#_Toc123842298)

[2.3 Linux Server als Router (vmLF3)	3](#_Toc123842299)

[3.0 Vorbereitung	4](#_Toc123842300)

[3.1 Modulspezifische Debianpakete	4](#_Toc123842301)

[3.2 Taggen der VMs	4](#_Toc123842302)

[4.0 MySQL Server + MySQL Workbench	5](#_Toc123842303)

[4.1 Erläuterung Vorgehen	5](#_Toc123842304)

[4.2 MySQL Server Installation und Konfiguration	5](#_Toc123842305)

[4.3 Datenbankbenutzer	6](#_Toc123842306)

[4.4 Query Log	6](#_Toc123842307)

[5.0 Datenbank	7](#_Toc123842308)

[5.1 ERD	7](#_Toc123842309)

[5.2 SQL Init Skript	8](#_Toc123842310)

[5.3 View Originalform	9](#_Toc123842311)

[5.4 Erstellung und Import der DB	10](#_Toc123842312)

[6.0 Abfrage über das Netzwerk (Applikation)	11](#_Toc123842313)

[6.1 Erklärung	11](#_Toc123842314)

[6.2 Installation gna (Webserver)	11](#_Toc123842315)

[8.0 Firewall	12](#_Toc123842316)

[8.1 ufw Konfiguration Linux	12](#_Toc123842317)




## 1. Einleitung
Wir haben in diesem Modul die Aufgabe bekommen, eine Datenbank aufzubauen und unser Resultat zu präsentieren. Für unser Projekt haben wir uns für eine Linux Umgebung entschieden, die Läuft auf einer Linux Server VM, so wie die MySQL Workbench, die läuft auch auf einer VM, nämlich auf einer Windows 11 VM, von dort aus kann auf den Linux Server zugegriffen werden auf die MySQL Server Instanz.
# 2.0 Übersicht Systeme
## 2.1 Linux Server (vmLS5)
Als MySQL Server Host, haben wir uns für den Linux Server entscheiden, da wir in der Gruppe schon Erfahrung hatten mit Linux und im Zusammenhang Linux Server und MySQL. 

Diese VM hat folgende Specs:

\- CPU:		1 Core

\- RAM:		4 GB

\- Hard Disks:	Hard Disk (ISCSI)	8 GB

Hard Disk 2 (ISCSI)	5 GB

Hard Disk 3 (ISCSI)	5 GB 

Hard Disk 4 (ISCSI)	5 GB 

Hard Disk 5 (ISCSI)	5 GB 
## 2.2 Windows Client (vmWP1)
Die Datenbank wollten wir über die MySQL Workbench bearbeiten und managen. Dazu haben wir uns für die Windows 11 VM entschieden. 

Diese VM hat folgende Specs:

\- CPU:		2 Cores

\- RAM:		4 GB

\- Hard Disks:	Hard Disk (ISCSI)	64 GB
## 2.3 Linux Server als Router (vmLF3)
Als Router machten wir den Gebrauch von der vmLF3, da die beiden anderen VMs (vmWP1 und vmLS5) im gleichen Netz sein mussten. Das konnten wir durch diese VM als Router verwirklichen.

Diese VM hat folgende Specs:

\- CPU:		1 Core

\- RAM:		1 GB

\- Hard Disk:	Hard Disk (ISCSI)	5 GB

\- Network Adapter:	NAT oder Bridged 

\- Network Adapter 2:	Custom (VMnet 1) (*Das LAN-Segment für die vmLS5 und vmWP1*)
# 3.0 Vorbereitung
## 3.1 Modulspezifische Debianpakete
Für dieses Modul brauchte es ein paar spezifische Pakete, die man zuerst installieren musste.

Für dieses Projekt mussten wir .deb Pakete installieren können. Dafür braucht es folgende zwei Befehle:

\- *sudo apt install gdebi* (gdebi ist die Software die es braucht um .deb Pakete zu installieren)
## 3.2 Taggen der VMs
Als erstes mussten wir unsere VMs "taggen", um sicher zu gehen, dass wir die VMs nicht von den Anderen übernehmen. 

Das haben wir für die Linux Server VM gemacht:

![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.002.png)

Das haben wir mit dem Tool "lintagger" gemacht.

Und für die Linux VM haben wir dasselbe gemacht:

![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.003.png)

Für die Windows VM haben wir es mit dem Tool "Wintagger" gemacht.


# 4.0 MySQL Server + MySQL Workbench
## 4.1 Erläuterung Vorgehen
Unser Plan war es, eine Verbindung von der Windows 11 VM (vmWP1) zu dem MySQL Server zu machen, der auf der vmLS5 läuft. Damit wir von dieser Windows VM die ganze Datenbank mit einem GUI bearbeiten und managen konnten. 

Damit wir das zustande brachten, mussten wir einige Konfigurationsschritte machen, damit das ganze geklappt hatte. Diese werden in den folgenden Kappiteln weiter beschrieben.
## 4.2 MySQL Server Installation und Konfiguration
Als erstes installieren wir den MySQL Dienst auf den Linux Server wie folgt:

|**Bild / Befehl**|**Beschriebung**|**Nr.**|
| :- | :- | :- |
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.004.png)|Als erstes updaten wir den "package index" auf unserem Server|1|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.005.png)|Hier installieren wir den MySQL Server|2|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.006.png)|Mit diesem Befehl gehen wir sicher, dass der MySQL Server auch wirklich läuft.|3|

Seit dem Juli 2022, gibt es ein Problem mit dem root Account, wenn man diesen nicht weiter konfiguriert, dass heisst man bekommt folgenden Error, wenn man auf die MySQL Konsole mit dem root Account zugreifen will:

![Text

Description automatically generated](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.007.png)

Dies kann man fixen indem man das Passwort vom root neu vergibt.


## 4.3 Datenbankbenutzer
Wichtig ist, dass es zwei Datenbankbenutzer gibt. Nämlich einer, der nur Leseberechtigung hat und einer der auch modify Rechte hat.

\- Der Benutzer david ist der mit den modify Rechten, dieser wird für das bearbeiten und erstellen der DB gebraucht. 

\- Der Benutzer dbread ist der Benutzer mit nur Leserechten. Dieser wird verwendet für den Webserver, um dort die Dateneinträge zu lesen.

![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.008.png)
## 4.4 Query Log
Wir wollen, dass wir sehen welche Aktionen auf dem mysql Server passieren. Dafür aktivieren wir das genreal log File.

|**Bild**|**Erklärung**|
| :- | :- |
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.009.png)|Damit die Logs auch geschrieben werden, muss man das zuerst aktivieren unter diesem Pfad in der Datei: mysqld.cnf|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.010.png)|In diesem File muss man dann die Zeilen mit general\_log\_file und general\_log den # entfernen damit dies aktiv ist und nicht mehr als Kommentar gilt.|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.011.png)|<p>Nun sollte man dies hier sehen, wenn man in mysql den Befehl:</p><p>Show variables like "%general%"</p><p>eingibt. Bei general\_log sollte "ON" stehen.</p>|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.012.png)|<p>Unter diesem Pfad: /var/log/mysql/query.log</p><p>werden dann alle "Aktionen" eingetragen, die auf dem mysql Server passieren.</p>|

# 5.0 Datenbank 
## 5.1 ERD
![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.013.png)
![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.014.png)
## 5.2 SQL Init Skript
![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.015.png)


## 5.3 View Originalform
![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.016.png)

![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.017.png)

Der View Originalform zeigt die ursprüngliche frigg Datei an.






## 5.4 Erstellung und Import der DB

|**Bild**|**Beschreibung**|
| :- | :- |
|- |Paulo hat auf seiner vmLS5 den frigg Export laufen lassen und eine Datei mit ganz vielen Datensätzen erhallten|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.018.png)|In einem zweiten Schritt hatte er aus dieser einzelnen frigg csv Datei mehrere csv Dateien gemacht, damit diese in die jeweiligen Tabellen importiert werden können. |
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.019.png)|Die Datenbank wurde anschliessend als dump file exportiert. Damit müssen wir nur noch eine Datei in MySQL Workbench importieren|



# 6.0 Abfrage über das Netzwerk (Applikation)
## 6.1 Erklärung
Es muss uns möglich sein, dass wir den Inhalt der Datenbank vom Browser aus aufrufen und einsehen können. In den nächsten Kapiteln wird erklärt wie wir das realisiert haben.
## 6.2 Installation gna (Webserver)

|**Bild**|**Beschreibung**|
| :- | :- |
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.020.png)|Als erstes muss man die Files gna\_0.7 und gna.conf.yml auf den Linux Server also auf die vmLS5 kopieren. Diese Programme braucht es für den Webserver.|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.021.png)|<p>Diese beiden Files packt man ins Verzeichnis /etc und führt die gna\_0.7\_all.deb Datei aus. </p><p></p><p>Zusätzlich braucht es noch diese beiden Commands:</p><p></p><p>$ sudo apt install libdbd-mysql-perl</p><p>$ sudo cpan install DBD::mysql</p><p></p><p>Das sind die Treiber für gna, damit eine Verbindung zum Datenbank Server hergestellt werden kann.</p>|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.022.png)|Im gna.conf.yml File gibt man dann noch die richtigen Credentials an für die Verbindung zum Datenbankserver.|
|![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.023.png)|Wenn man alles konfiguriert hat, muss man in der Konsole noch "gna" eingeben und Enter drücken, somit startet man den Webserver.|

**Wichtig:**

Der Benutzer, welcher über den Webserver auf die DB zugreift ist der: "dbread", denn dieser sollte keine modify Rechte besitzen, dieser ist rein dazu da, um die Datenbankeinträge über den Webserver einsehen zu können.
# 8.0 Firewall
## 8.1 ufw Konfiguration Linux
Damit man von einem Client aus, auf den Webserver zugreifen kann, muss dieser Port bei der Firewall auf dem Server (vmLS5) freigegeben werden.

Befehle:

$ sudo ufw allow 3000

Ergebnis:

![](resources/Aspose.Words.607c49ea-6ab0-4243-a040-6ce958589b18.026.png)

Es sollten zwei neue Einträge erscheinen:

3000 ALLOW Anywhere

3000 (v6) ALLOW Anywhere














2

