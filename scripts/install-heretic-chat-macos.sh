#!/usr/bin/env bash
# Install a pre-abliterated Heretic model as a separate Ollama chat model on macOS.
# No changes to Heretic itself, Open WebUI, or existing Ollama models.
set -euo pipefail

SOURCE="hf.co/bartowski/p-e-w_Qwen3-4B-Instruct-2507-heretic-GGUF:Q4_K_M"
ALIAS="heretic:4b"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This helper is for macOS. See docs/UTILISER-HERETIC-COMME-IA.md for manual steps." >&2
  exit 1
fi

if ! command -v ollama >/dev/null 2>&1; then
  echo "Ollama is not installed or is not on PATH. Install/open Ollama first." >&2
  exit 1
fi

if ! ollama list >/dev/null 2>&1; then
  echo "Ollama does not appear to be running. Start the Ollama macOS app and retry." >&2
  exit 1
fi

if ollama show "$ALIAS" >/dev/null 2>&1; then
  echo "The model name $ALIAS already exists. Nothing was overwritten."
  echo "Try: ollama run $ALIAS"
  exit 0
fi

echo "Downloading the pre-abliterated Qwen3 4B GGUF (~2.5 GB)."
ollama pull "$SOURCE"
echo "Creating local alias $ALIAS (preserving existing other models)."
ollama cp "$SOURCE" "$ALIAS"
ollama show "$ALIAS" >/dev/null

echo ""
echo "Done. Start a conversation:"
echo "  ollama run $ALIAS"
echo "Open WebUI: refresh the model list and select $ALIAS."
echo "For SuperAgent: configure an Ollama provider with model ID $ALIAS."
echo "Do not expose Ollama's local API to the public internet."
