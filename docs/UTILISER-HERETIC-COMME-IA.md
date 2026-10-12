# Utiliser Heretic comme une IA de conversation (Mac + Ollama + Open WebUI)

> **Important :** ce dépôt contient le programme **Heretic**, qui modifie des modèles de langage par abliteration. Le dépôt n'est **pas** un modèle de chat, et un simple fork ne fournit pas de poids de modèle. Pour discuter immédiatement avec une IA issue d'Heretic, on charge un **modèle déjà transformé** dans Ollama.

## Solution rapide : Mac Apple Silicon (dont M3, 16 Go de mémoire unifiée)

Prérequis : [Ollama](https://ollama.com/) installé et lancé, accès Internet pour le premier téléchargement, environ 3 Go de stockage libre pour la quantification proposée (prévoir davantage d'espace libre pour les fichiers temporaires et Ollama). Un modèle 4B en Q4_K_M est plus adapté à une machine de 16 Go qu'un modèle 12B ou plus.

Depuis la racine du dépôt :

```bash
bash scripts/install-heretic-chat-macos.sh
```

Ou **sans script**, dans le Terminal de macOS :

```bash
ollama pull hf.co/bartowski/p-e-w_Qwen3-4B-Instruct-2507-heretic-GGUF:Q4_K_M
ollama cp hf.co/bartowski/p-e-w_Qwen3-4B-Instruct-2507-heretic-GGUF:Q4_K_M heretic:4b
ollama run heretic:4b
```

Le modèle provient de [bartowski/p-e-w_Qwen3-4B-Instruct-2507-heretic-GGUF](https://huggingface.co/bartowski/p-e-w_Qwen3-4B-Instruct-2507-heretic-GGUF), une **conversion communautaire** du modèle [p-e-w/Qwen3-4B-Instruct-2507-heretic](https://huggingface.co/p-e-w/Qwen3-4B-Instruct-2507-heretic). Vérifier les licences et la provenance des poids avant toute redistribution. Cette étape ne lance **pas** une nouvelle abliteration et n'utilise pas directement le code de ce fork.

### Dans Open WebUI

1. Démarrer Ollama, puis Open WebUI comme d'habitude.
2. Vérifier `ollama list` : `heretic:4b` doit apparaître.
3. Dans un nouveau chat Open WebUI, rafraîchir la liste des modèles et choisir **heretic:4b**.
4. Conserver les autres modèles Ollama pour comparer la fiabilité des réponses.

Si le modèle n'apparaît pas, vérifier que l'instance Open WebUI se connecte bien au **même serveur Ollama** (sur Mac local, normalement `http://127.0.0.1:11434`) et actualiser les modèles. Ne pas ouvrir ce port directement sur Internet.

### Dans SuperAgent

Si SuperAgent prend en charge les modèles via ton serveur Ollama, renseigner l'identifiant **`heretic:4b`** parmi les modèles du fournisseur local. Il faut que le serveur Mac soit joignable depuis SuperAgent ; cela n'est pas assuré lorsque le Mac est éteint. L'accès réseau et l'authentification doivent être configurés séparément.

**Attention aux actions automatisées :** la modification des mécanismes de refus ne confère pas à un modèle des capacités d'agent, de navigation, de gestion GitHub ni de programmation supplémentaires. Pour toute modification de dépôts ou de production, conserver des contrôles indépendants (autorisations, outils restreints, validations humaines avant actions sensibles).

## Différence entre programme et modèle

| Élément | Fonction |
| --- | --- |
| Ce fork GitHub `heretic` | Code Python pour transformer des modèles existants |
| Modèle Qwen3 4B « heretic » en GGUF | Poids déjà transformés, prêts à être chargés dans Ollama |
| Ollama | Exécution locale du modèle |
| Open WebUI | Interface de chat, historique et sélection de modèles |
| SuperAgent | Orchestration et intégrations, si elles sont configurées |

### Si tu veux transformer toi-même un modèle

Le README principal documente `heretic <identifiant_de_modele>` après installation des dépendances Python. C'est un processus distinct, beaucoup plus gourmand en mémoire et en calcul. Sur Apple Silicon, le support MPS peut être variable selon l'architecture du modèle ; prévoir des essais sur un **petit modèle** et conserver l'original. Le fork est actuellement sur `master` en version de développement (voir `pyproject.toml`) ; les exemples plus anciens de `config.toml` peuvent être incompatibles.

Ne pas tenter de traiter directement un modèle quantifié Ollama `*.gguf` comme si c'était le modèle Transformer source : Heretic travaille avec les poids et formats pris en charge par sa chaîne Python.

## Vérification

```bash
ollama list
ollama show heretic:4b
ollama run heretic:4b "Réponds en français : explique en trois phrases ce qu'est Heretic."
```

Une sortie cohérente valide le fonctionnement de base, **pas** les qualités ni la sûreté du modèle. Effectuer des tests comparatifs avant de l'employer avec des outils ayant accès à des données privées.

Sources :
- [Projet original Heretic](https://github.com/p-e-w/heretic)
- [Documentation Hugging Face : Ollama + GGUF](https://huggingface.co/docs/hub/en/ollama)
- [Documentation Ollama : importer des modèles](https://docs.ollama.com/import)
- [Modèle GGUF communautaire](https://huggingface.co/bartowski/p-e-w_Qwen3-4B-Instruct-2507-heretic-GGUF)
