# Générateur de clés maître et sous-clés GnuPG 25519 (sans intervention)
# Formateur de dongle USB-Luks (stockage de clés GPG).

Présentation
Ce dépôt contient un ensemble de scripts permettant de générer des clés maître et sous-clés GPG à l'aide d'une clé USB chiffrée LUKS. Ces scripts sont conçus pour les utilisateurs non root, mais nécessitent un accès root pour certaines opérations. Cette configuration est optimisée pour Debian Trixie et est destinée aux utilisateurs travaillant sur du matériel ancien sans accès à Internet pendant le processus.

Remarques importantes

* Ordre d'exécution : Les scripts doivent être exécutés dans l'ordre indiqué : FIRST, SECOND et THIRD. Ne sautez aucune étape, même si l'une d'elles échoue.

* Environnement : Assurez-vous de disposer des fichiers nécessaires :

FIRST.sh

SECOND.sh

THIRD.sh

(optionnel : batchproduction_ofTHIRD.sh)

… dans votre répertoire Téléchargements avant de commencer.

# POUR LA PRODUCTION PAR LOT (recommandé !)

* Si vous avez plusieurs adresses e-mail pour lesquelles vous souhaitez générer des clés GPG, exécutez les commandes suivantes en tant qu'utilisateur root ou avec sudo :

```bash
sudo bash /home/$USER/Downloads/FIRST.sh;
sudo bash /home/$USER/Downloads/SECOND.sh;
```

* Créez deux fichiers :

un avec une colonne de propriétaires,

un second avec une colonne d'adresses e-mail

et alimentez-les en remplaçant les champs d'arguments selon le modèle suivant :

```bash
/home/$USER/Downloads/batchproduction_ofTHIRD.sh <path/to/and/ownerfile.txt> <path/to/and/addressfile.txt>;
```

Ce dernier script vous permet d'importer des listes d'adresses e-mail et leurs propriétaires respectifs, générant ainsi un script bash individuel pour chaque adresse.

* Lorsque vous exécuterez les scripts individuels générés, ils créeront des clés GPG stockées sur votre clé USB chiffrée LUKS. Important : OpenGPG recommande d'utiliser immédiatement puis de supprimer toute clé privée non chiffrée afin d'éviter de stocker des informations sensibles.

# OU CHOISISSEZ LA PRODUCTION DE CLÉ UNIQUE (intuitif).

Étapes à suivre

Étape 1 : Exécuter le premier script

1. Ouvrez un terminal.

2. Exécutez la commande suivante en tant qu'utilisateur root ou avec sudo :

```bash
 bash /home/$USER/Downloads/FIRST.sh
```


Étape 2 : Créer la clé USB avec LUKS

1. Démarrez cette étape en mode root :

```bash
 bash /home/$USER/Downloads/SECOND.sh
```

Étape 3 : Enregistrer la clé principale et les sous-clés GPG sur la clé USB

1. Démarrez cette étape en mode root. Vous devrez peut-être modifier les permissions du script pour le rendre exécutable.

Utilisez la commande suivante :

```bash
 chmod +x /home/$USER/Downloads/THIRD.sh
```

2. Ensuite, exécutez le script :

```bash
 /home/$USER/Downloads/THIRD.sh
```

Dernière étape : Démonter la clé USB en toute sécurité

Après avoir suivi toutes les étapes, assurez-vous de démonter votre clé USB LUKS en toute sécurité afin d'éviter tout problème lors de sa reconnexion :

```bash
sudo umount "/mnt/usb_gpg"
sudo cryptsetup luksClose myusb_key
```

ou lors de votre prochaine connexion, vous pourriez rencontrer des difficultés.

Conclusion

En suivant ces étapes, vous pouvez générer et stocker en toute sécurité votre clé principale et vos sous-clés GPG sur une clé USB chiffrée avec LUKS. Manipulez toujours vos clés privées avec précaution et suivez les bonnes pratiques de sécurité. Pour toute question ou problème, veuillez consulter la documentation ou demander de l'aide à la communauté.
