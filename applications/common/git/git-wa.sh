# 引数が指定されているかどうかを判定する
if [ $# -ne 1 ]; then
  echo "Usage: git wa <branch>"
  exit 1
fi

branch="$1"

# カレントディレクトリが git の管理下にあるかどうかを判定する
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not in a git repository"
  exit 1
fi

# カレントディレクトリが git の管理下にある場合、ghq の管理下にあるかどうか判定する
if ! ghq list --full-path | grep -q "$(pwd)"; then
  echo "Not in a ghq managed git repository"
  exit 1
fi

# カレントディレクトリが ghq の管理下にある場合、ghq のリポジトリ名を取得する
repo_query="$(basename "$(dirname "$(pwd)")")/$(basename "$(pwd)")"
repo_name="$(ghq list --exact "$repo_query")"

# $HOME/worktrees/$repo_name を作成する
if [ ! -d "$HOME/worktrees/$repo_name" ]; then
  mkdir -p "$HOME/worktrees/$repo_name"
fi

# $HOME/worktrees/$repo_name/$branch に git worktree add する
TARGET="$HOME/worktrees/$repo_name/$branch"

git worktree add "$TARGET"

# もし .envrc が存在する場合、.envrc のシンボリックリンクを作成しつつ allow する
if [ -f ".envrc" ] && [ ! -e "$TARGET/.envrc" ]; then
  ln -s "$(pwd)/.envrc" "$TARGET/.envrc"
  direnv allow "$TARGET"
fi

# 特定のディレクトリが存在する場合にはシンボリックリンクを作成する
for d in ".warashi" ".cursor" ".claude" ".kiro"; do
  if [ -d "$d" ] && [ ! -e "$TARGET/$d" ]; then
    ln -s "$(pwd)/$d" "$TARGET/$d"
  fi
done

# 特定のファイルが存在する場合にはシンボリックリンクを作成する
for f in "shell.nix" "CLAUDE.md" ".mcp.json" ".cursorignore"; do
  if [ -f "$f" ] && [ ! -e "$TARGET/$f" ]; then
    ln -s "$(pwd)/$f" "$TARGET/$f"
  fi
done
