1. Règles du jeu (gameplay)
Chaque mot est un terme de programmation/informatique en anglais.

Longueur du Mot du Jour :

Parfois 5 lettres, parfois 6 lettres,

choisi au hasard dans la liste (qui est triée alphabétiquement).

Nombre d’essais : 6 tentatives maximum.

Feedback par lettre (comme Wordle) :

Vert : bonne lettre, bonne position.

Jaune : lettre présente ailleurs dans le mot.

Gris : lettre absente du mot.

Tu peux jouer :

1 fois par jour le Mot du Jour (unique, commun à tout le monde).

Jusqu’à 3 fois/jour en Mot Libre (plus avec pubs ou premium).

Pas de Hard Mode pour l’instant (on gardera ça pour plus tard).

2. Modes de jeu
Mot du Jour
À minuit (UTC ou fuseau à définir), on change de mot.

Le mot est choisi en prenant un index pseudo-aléatoire dans la liste complète, qui contient des mots 5 et 6 lettres triés alphabétiquement.

Même mot pour tous les joueurs ce jour-là.

Statut :

Si le joueur a fini sa partie (gagné ou perdu), il ne peut pas rejouer le Mot du Jour.

Le résultat (succès/échec) alimente ses Stats et son streak.

Mot Libre
L’utilisateur lance une partie d’entraînement, le mot est choisi aléatoirement dans la même liste de mots (5 ou 6 lettres, au hasard).

Par défaut, 3 parties par jour en version gratuite.

Au-delà :

Popup : “You reached today’s free plays. Watch an ad to play another word.”

Bouton “Watch ad” → débloque 1 partie supplémentaire.

Pour un utilisateur premium (achat Remove Ads) :

Mot Libre sans limite (pas de pubs, pas de popup).

3. Monétisation (modèle précis)
Bannières pubs
Bannière en bas de l’écran (Ad banner) :

Visible sur Home, Mot du Jour, Mot Libre, Stats, Settings.

Masquée dès que l’utilisateur achète Remove Ads (3.99€).

Rewarded Ads (Mot Libre)
3 parties “Free Word” par jour sans pub.

Pour chaque partie supplémentaire :

L’utilisateur regarde une pub vidéo (rewarded ad).

Une fois la pub terminée → 1 partie Mot Libre supplémentaire.

Si l’utilisateur a acheté Remove Ads (3.99€) :

Mot Libre illimité, sans ads.

Achat unique Premium – “Remove Ads” (3.99€)
Supprime toutes les pubs :

Plus de bannière.

Plus de rewarded ads.

Confère :

Mot Libre illimité.

Affichage d’un petit badge “Premium” dans Stats/Settings.

Pas d’abonnement récurrent, uniquement ce one-shot.

4. Écrans (UX globale)
Home
Titre/logo Devle (provisoire).

4 boutons principaux :

“Daily Word”

“Free Word”

“Stats”

“Settings”

Bannière pub en bas (sauf premium).

Daily Word
Grille de 6 essais, chaque ligne : 5 ou 6 cases selon le mot du jour.

Clavier virtuel (QWERTY) sous la grille.

Affichage du nombre d’essais restants.

Écran fin :

Victoire : “You found the word in X tries!” + résumé.

Défaite : “The word was XXXXX.”

Bouton “Back to Home”.

Free Word
Idem Daily, mais :

Indication du nombre de parties “Free Word” restantes aujourd’hui (3 max en free).

Après 3 jeux : proposition “Watch ad for extra game”.

Pour premium : cette limitation disparaît.

Stats
Total games played (Daily + Free).

Win rate (%).

Distribution (victoire en 1,2,3,4,5,6 essais).

Current streak (Daily uniquement) + best streak.

Settings
Langue interface (plus tard, mais prévu).

Theme (dark/light).

Clavier : QWERTY / AZERTY.

Bouton “Remove Ads – 3.99€” si pas encore acheté.

5. Dictionnaire de mots (principes)
Liste triée alphabétiquement.

Mots seulement en anglais, liés à la programmation/informatique (no random everyday words).

Longueur uniquement 5 ou 6 lettres.

On vise au minimum 300 mots pour commencer, idéalement plus (500–800).

Mix de catégories : structures, outils, concepts, pratiques (array, stack, queue, debug, parse, commit, merge, docker, cloud, mutex, etc.).

Le Mot du Jour et les Free Words piochent dans la même liste, dans laquelle il y a des mots 5 et des mots 6 lettres. La longueur est donc aléatoire pour chaque partie