# Devle – TODO / Roadmap

**Projet** : Wordle adapté aux termes de programmation  
**Dépôt** : https://github.com/vfaust1/Devle  
**Dernière mise à jour** : 3 février 2026

---

## 🚀 Roadmap – Prochaines étapes

### Étape 1 – Finaliser le core game ⚡

- [ ] Indicateur Daily Word
  - [ ] Badge "NEW" sur le bouton Daily si pas encore joué aujourd'hui
  - [ ] Badge "DONE" si déjà joué
  - [ ] (Optionnel) Afficher le temps avant le prochain mot

---

### Étape 2 – Free Word + Premium 📅

- [ ] Écran de limite atteinte
  - [ ] Ajouter les options :
    - Regarder une pub pour débloquer +1 partie
    - Acheter Premium pour illimité (redirige vers écran Premium)

---

### Étape 3 – Monétisation (Publicités réelles) 💰

- [ ] Intégration Google Mobile Ads
  - [ ] Ajouter le package `google_mobile_ads`
  - [ ] Configurer AdMob pour Android et iOS
  - [ ] Ajouter `app-ads.txt` sur un domaine (GitHub Pages ou autre) si tu veux optimiser le fill rate

- [ ] Bannières publicitaires
  - [ ] Afficher une bannière en bas des écrans : Home, Daily, Free, Stats, Settings
  - [ ] Masquer automatiquement les bannières si `premiumUnlocked == true`

- [ ] Rewarded Ads pour Free Word
  - [ ] Bouton "Watch ad to play another word" après la limite
  - [ ] Incrémenter le quota si la pub est vue complètement
  - [ ] Gérer les erreurs (pub non dispo, échec chargement)

---

### Étape 4 – Premium IAP (achats réels) 💎

- [ ] In-App Purchase
  - [ ] Intégrer `in_app_purchase`
  - [ ] Configurer Google Play Console : achat unique "Remove Ads – 3.99€"
  - [ ] (Plus tard) Configurer App Store Connect (iOS)

- [ ] Relier premium system ↔ IAP
  - [ ] Sauvegarder/restaurer `premiumUnlocked` via les achats
  - [ ] Vérifier le statut au lancement
  - [ ] Afficher un badge "Premium" dans Settings/Stats

- [ ] Désactivation complète des pubs
  - [ ] Masquer bannières si premium
  - [ ] Désactiver rewarded ads
  - [ ] Free Word illimité

- [ ] UI Premium dans Settings
  - [ ] Section "Remove Ads – 3.99€"
  - [ ] Afficher "Purchased ✓" si déjà acheté
  - [ ] Bouton "Restore Purchase"

---

### Étape 5 – UX / Polish ✨

- [ ] Page About / Credits
  - [ ] Description du jeu
  - [ ] Lien GitHub
  - [ ] Version de l'app (déjà gérée, juste l’afficher clairement ici)
  - [ ] Contact / feedback

- [ ] Feedback sonore (optionnel)
  - [ ] Son au tap des touches
  - [ ] Son victoire/défaite
  - [ ] Option pour désactiver les sons dans Settings

---

### Étape 6 – Tests & Qualité 🧪

- [ ] Tests unitaires
  - [ ] Fonction comparaison guess/secret (couleurs)
  - [ ] Logique victoire/défaite
  - [ ] Calcul Daily Word (date → index)
  - [ ] Comportement du compteur Free Word

- [ ] Tests widgets
  - [ ] Affichage et mise à jour de la grille
  - [ ] Interaction clavier virtuel
  - [ ] Écrans victoire/défaite

- [ ] CI/CD GitHub Actions
  - [ ] Workflow Flutter :
    - `flutter format --set-exit-if-changed`
    - `dart analyze`
    - `flutter test`
  - [ ] Lancer sur chaque push / pull request

---

### Étape 7 – Déploiement & Distribution 🌐

- [ ] Web (démo)
  - [ ] `flutter build web --release`
  - [ ] Déployer (GitHub Pages, Netlify, etc.)
  - [ ] Ajouter le lien de la démo dans le README

- [ ] Android
  - [ ] Générer un APK signé pour tests
  - [ ] Tester sur plusieurs devices
  - [ ] Préparer les assets Play Store (icône, screenshots, description)
  - [ ] Publier sur Google Play

- [ ] iOS (plus tard)
  - [ ] Config Xcode + certificats
  - [ ] Build iOS
  - [ ] Tests simulateur / devices
  - [ ] Soumission App Store

- [ ] Desktop (optionnel)
  - [ ] Build Windows / macOS / Linux
  - [ ] Publier les exécutables dans GitHub Releases

---

## 📌 Priorités

1. Étapes 1–2 : Core game nickel + différenciation premium / non‑premium  
2. Étapes 3–4 : Monétisation (pubs + IAP)  
3. Étape 5 : Polish UX  
4. Étapes 6–7 : Tests + déploiement public

Bon dev ! 🚀
