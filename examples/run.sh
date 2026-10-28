#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_brain_council info
PYTHONPATH=src python -m gbt_brain_council check --payload '{"op": "<在此填写>", "question": "<在此填写>"}'
PYTHONPATH=src python -m gbt_brain_council run   --payload '{"op": "<在此填写>", "question": "<在此填写>"}'
