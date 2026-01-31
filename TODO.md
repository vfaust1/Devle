# Devle – TODO / Roadmap

---

## 📋 État actuel du projet

### ✅ Ce qui est déjà fait

- [x] Structure du projet Flutter (multi-plateforme : Web, Windows, macOS, Linux, Android, iOS)
- [x] Deux modes de jeu : Daily Word Challenge + Free Play Mode
- [x] Mécanique Wordle complète : 6 essais, feedback vert/jaune/gris par lettre
- [x] Clavier virtuel fonctionnel (ENT / DEL)
- [x] Système de stats de base (victoires, win rate, streak)
- [x] Persistance des données (shared_preferences)
- [x] Dictionnaire de mots techniques (5 et 6 lettres)
- [x] Thème Dark/Light
- [x] Interface responsive (mobile, tablet, desktop, web)
- [x] README complet avec instructions d'installation et build

---

## 🚀 Roadmap – Prochaines étapes

### **Étape 1 – Solidifier le core game** ⚡ *Priorité haute*

- [ ] **Daily Word déterministe**
  - [ ] Vérifier que le mot du jour est calculé par date (hash → index dictionnaire)
  - [ ] S'assurer que tous les joueurs ont le même mot quotidien
  - [ ] Bloquer la possibilité de rejouer le Daily une fois terminé (win/lose)
  - [ ] Afficher un indicateur visuel "DONE" sur le bouton Daily si déjà joué aujourd'hui

- [ ] **Validation des entrées**
  - [x] Implémenter la vérification : le mot saisi doit être dans le dictionnaire
  - [x] Afficher un message d'erreur si mot invalide ("Word not in list")

---

### **Étape 2 – Free Word avec quotas journaliers** 📅

- [ ] **Système de compteur quotidien**
  - [ ] Ajouter un compteur `freeGamesToday` (shared_preferences)
  - [ ] Reset automatique à minuit (vérification à l'ouverture de l'app)
  - [ ] Limiter à **3 parties gratuites par jour** pour les utilisateurs non-premium

- [ ] **Écran de limite atteinte**
  - [ ] Afficher un message après 3 parties : "You've reached your free plays today"
  - [ ] Proposer deux options :
    - Regarder une pub pour débloquer +1 partie
    - Acheter Premium pour illimité

---

### **Étape 3 – Monétisation v1 (Publicités)** 💰

- [ ] **Intégration Google Mobile Ads**
  - [ ] Ajouter le package `google_mobile_ads` (ou équivalent)
  - [ ] Configurer AdMob pour Android et iOS
  - [ ] Obtenir les AdUnit IDs (test puis production)

- [ ] **Bannières publicitaires**
  - [ ] Afficher une bannière en bas des écrans : Home, Daily Word, Free Word, Stats, Settings
  - [ ] Ne pas afficher si `premiumUnlocked == true`

- [ ] **Rewarded Ads pour Free Word**
  - [ ] Bouton "Watch an ad to play another word" après les 3 parties gratuites
  - [ ] Incrémenter le quota si la pub est vue
  - [ ] Gérer les erreurs (pub non disponible, échec du chargement)

---

### **Étape 4 – Premium "Remove Ads"** 💎

- [ ] **In-App Purchase (IAP)**
  - [ ] Intégrer le package `in_app_purchase`
  - [ ] Configurer Google Play Console (Android) pour l'achat "Remove Ads – 3.99€"
  - [ ] (Plus tard) Configurer App Store Connect (iOS)

- [ ] **Gestion du statut Premium**
  - [ ] Sauvegarder un booléen `premiumUnlocked` en local
  - [ ] Vérifier le statut à chaque lancement (restauration d'achat)
  - [ ] Afficher un badge "Premium" dans Settings/Stats

- [ ] **Désactivation des pubs pour les premium**
  - [ ] Masquer toutes les bannières si premium
  - [ ] Désactiver les rewarded ads pour Free Word
  - [ ] Free Word illimité (pas de limite des 3 parties)

- [ ] **Bouton Premium dans Settings**
  - [ ] Ajouter une section "Remove Ads – 3.99€"
  - [ ] Afficher "Purchased ✓" si déjà acheté
  - [ ] Bouton "Restore Purchase" pour récupérer l'achat sur nouvel appareil

---

### **Étape 5 – UX / Polish** ✨

- [ ] **Animations**
  - [ ] Shake de la ligne si mot invalide (pas dans le dico / longueur incorrecte)
  - [ ] Flip des cases lors de la révélation des couleurs
  - [ ] Animation de victoire (confettis ou effet visuel)

- [ ] **Indicateurs visuels**
  - [ ] Badge "NEW" sur Daily Word si pas encore joué aujourd'hui
  - [ ] Badge "DONE" si déjà joué
  - [ ] Afficher le temps restant avant le prochain mot quotidien

- [ ] **Page About / Credits**
  - [ ] Créer un écran About avec :
    - Description du jeu
    - Lien GitHub
    - Version de l'app
    - Contact/feedback

- [ ] **Feedback sonore (optionnel)**
  - [ ] Son au tap des touches
  - [ ] Son de victoire/défaite
  - [ ] Option pour désactiver les sons dans Settings

---

### **Étape 6 – Tests & Qualité** 🧪

- [ ] **Tests unitaires**
  - [ ] Tester la fonction de comparaison guess vs secret (couleurs vert/jaune/gris)
  - [ ] Tester la logique de victoire/défaite
  - [ ] Tester le calcul du mot du jour (date → index)
  - [ ] Tester le reset quotidien du compteur Free Word

- [ ] **Tests widgets**
  - [ ] Tester l'affichage de la grille
  - [ ] Tester l'interaction avec le clavier virtuel
  - [ ] Tester l'écran de victoire/défaite

- [ ] **CI/CD avec GitHub Actions**
  - [ ] Configurer un workflow Flutter :
    - `flutter format --set-exit-if-changed`
    - `dart analyze`
    - `flutter test`
  - [ ] Exécuter à chaque push / pull request

---

### **Étape 7 – Déploiement & Distribution** 🌐

- [ ] **Web (GitHub Pages ou autre)**
  - [ ] `flutter build web --release`
  - [ ] Déployer sur GitHub Pages pour avoir une démo jouable
  - [ ] Ajouter le lien de la démo dans le README

- [ ] **Android**
  - [ ] Générer un APK signé pour tests
  - [ ] Tester sur plusieurs appareils physiques
  - [ ] Préparer les assets Play Store (icône, screenshots, description)
  - [ ] Publier sur Google Play Store (en interne d'abord, puis production)

- [ ] **iOS (plus tard)**
  - [ ] Configurer Xcode et certificats
  - [ ] Générer un build iOS
  - [ ] Tester sur simulateur et devices
  - [ ] Publier sur App Store

- [ ] **Desktop (optionnel)**
  - [ ] Build Windows : `flutter build windows`
  - [ ] Build macOS : `flutter build macos`
  - [ ] Build Linux : `flutter build linux`
  - [ ] Distribution via GitHub Releases

---

## 🔮 Idées futures (Backlog)

- [ ] **Multilingue FR/EN**
  - [ ] Traduction des menus et messages
  - [ ] Dictionnaires séparés FR/EN
  - [ ] Sélecteur de langue dans Settings

- [ ] **Layout clavier AZERTY / QWERTY**
  - [ ] Option dans Settings pour choisir le layout
  - [ ] Adapter l'ordre des touches du clavier virtuel

- [ ] **Mode Hard Mode**
  - [ ] Forcer à réutiliser les lettres vertes/jaunes dans les essais suivants
  - [ ] Badge "Hard Mode" dans les stats

- [ ] **Partage de résultats**
  - [ ] Générer une grille emoji (🟩🟨⬜) comme Wordle
  - [ ] Bouton "Share" pour copier dans le presse-papier
  - [ ] Option de partage sur réseaux sociaux

- [ ] **Classement / Leaderboard**
  - [ ] Comparer les stats avec d'autres joueurs
  - [ ] Intégration Firebase pour sync cloud (optionnel)

- [ ] **Thèmes de couleurs personnalisés**
  - [ ] Mode daltonien (colorblind mode)
  - [ ] Variantes de couleurs (bleu/orange, etc.)

---

## 📌 Notes et priorités

- **Priorité 1** : Étapes 1–2 (core game + quotas) → base solide pour jouer
- **Priorité 2** : Étapes 3–4 (monétisation) → rentabiliser l'app
- **Priorité 3** : Étape 5 (polish) → améliorer l'expérience utilisateur
- **Priorité 4** : Étapes 6–7 (qualité + déploiement) → rendre l'app professionnelle
