#!/usr/bin/env bash
# Forge Cloud workspace setup: register the marc-hub MCP (stdio wrapper) and a CLAUDE.md block. Fast, idempotent.
set -uo pipefail
DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.local/bin" "$HOME/.claude"
ln -sfn "$DIR/marc-hub-stdio" "$HOME/.local/bin/marc-hub-stdio"
python3 - "$DIR" <<'PY'
import json, os, re, sys
d = sys.argv[1]
p = os.path.expanduser("~/.claude.json")
try:
    cfg = json.load(open(p))
except (OSError, ValueError):
    cfg = {}
cfg.setdefault("mcpServers", {})["marc-hub"] = {"type": "stdio", "command": "python3",
                                                 "args": [os.path.join(d, "marc-hub-stdio")]}
json.dump(cfg, open(p + ".tmp", "w"), indent=2)
os.replace(p + ".tmp", p)
b = os.path.expanduser("~/.claude/CLAUDE.md")
s = open(b).read() if os.path.exists(b) else ""
s = re.sub(r"<!-- BEGIN marc-hub -->.*?<!-- END marc-hub -->\n?", "", s, flags=re.S).rstrip()
blk = open(os.path.join(d, "claude-md-block.md")).read().strip()
open(b, "w").write((s + "\n\n" if s else "") + blk + "\n")
PY
echo "forge dotfiles: marc-hub registered"
