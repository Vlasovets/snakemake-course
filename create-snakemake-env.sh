#!/usr/bin/env bash
set -euo pipefail

# Reproduce the Snakemake course environment used in this repository.
# Usage:
#   bash create-snakemake-env.sh
#   bash create-snakemake-env.sh --recreate

ENV_NAME="snakemake_carpentry"
SNAKEMAKE_VERSION="8.5.3"
RECREATE=false

for arg in "$@"; do
  case "$arg" in
    --recreate)
      RECREATE=true
      ;;
    -h|--help)
      cat <<'EOF'
Create the Snakemake course environment.

Options:
  --recreate   Remove existing environment before creating it again
  -h, --help   Show this help
EOF
      exit 0
      ;;
    *)
      echo "Error: Unknown argument '$arg'" >&2
      exit 1
      ;;
  esac
done

if ! command -v conda >/dev/null 2>&1; then
  echo "Error: conda was not found on PATH." >&2
  echo "Install Miniconda/Anaconda first, then rerun this script." >&2
  exit 1
fi

# Load conda shell functions in case this runs in a shell without prior init.
if ! type conda 2>/dev/null | grep -q "function"; then
  CONDA_BASE="$(conda info --base)"
  # shellcheck disable=SC1090
  source "$CONDA_BASE/etc/profile.d/conda.sh"
fi

if conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
  if [ "$RECREATE" = true ]; then
    echo "Removing existing environment: $ENV_NAME"
    conda env remove -n "$ENV_NAME" -y
  else
    echo "Environment '$ENV_NAME' already exists."
    echo "Use --recreate if you want a fresh rebuild."
    exit 0
  fi
fi

echo "Creating environment '$ENV_NAME'..."
conda create -y \
  -n "$ENV_NAME" \
  -c bioconda \
  -c conda-forge \
  "snakemake=${SNAKEMAKE_VERSION}" \
  fastqc \
  kallisto \
  multiqc

CONDA_BASE="$(conda info --base)"
ENV_BIN="$CONDA_BASE/envs/$ENV_NAME/bin"

echo
echo "Installed versions:"
"$ENV_BIN/snakemake" --version
"$ENV_BIN/fastqc" --version
"$ENV_BIN/kallisto" version | head -n 1
PYTHONNOUSERSITE=1 "$ENV_BIN/multiqc" --version

echo
echo "Done. Activate with:"
echo "  conda activate $ENV_NAME"
