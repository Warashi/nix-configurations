# 1. パスの解決と XDG 設定ディレクトリの特定
TARGET_DIR=$(realpath "${1:-$(pwd)}")
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
FALLBACK_CONFIG="$CONFIG_HOME/dshell/default/devcontainer.json"
OVERRIDE_CONFIG="$CONFIG_HOME/dshell/override/devcontainer.json"
TMP_CONFIG_DIR="$(mktemp -d)"
TMP_CONFIG="$TMP_CONFIG_DIR/devcontainer.json"

cleanup() {
  # クリーンアップ関数
  CONTAINER_ID=$(docker ps -q --filter "label=devcontainer.local_folder=$TARGET_DIR")
  [ -n "$CONTAINER_ID" ] && docker rm -f "$CONTAINER_ID"
  rm -rf "$TMP_CONFIG_DIR"
}
trap cleanup EXIT

# 2. devcontainer.json の探索
if [ -f "$TARGET_DIR/.devcontainer/devcontainer.json" ]; then
  config-merger "$TMP_CONFIG" "$TARGET_DIR/.devcontainer/devcontainer.json" "$OVERRIDE_CONFIG"
elif [ -f "$TARGET_DIR/.devcontainer.json" ]; then
  config-merger "$TMP_CONFIG" "$TARGET_DIR/.devcontainer.json" "$OVERRIDE_CONFIG"
elif [ -f "$FALLBACK_CONFIG" ]; then
  config-merger "$TMP_CONFIG" "$FALLBACK_CONFIG" "$OVERRIDE_CONFIG"
else
  echo "❌ エラー: devcontainer.json も $FALLBACK_CONFIG も見つかりません。"
  exit 1
fi

# 2. Git 情報などの取得
U_NAME=$(git config --get user.name)
U_EMAIL=$(git config --get user.email)
GIT_ROOT=$(git -C "$TARGET_DIR" rev-parse --show-toplevel 2>/dev/null)
GIT_COMMON_DIR="$(cd "$(git -C "$TARGET_DIR" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" && cd .. && pwd)"

COMMON_OPTS=()
COMMON_OPTS+=("--mount-workspace-git-root")
COMMON_OPTS+=("--override-config" "$TMP_CONFIG")
COMMON_OPTS+=("--workspace-folder" "$TARGET_DIR")

MOUNT_ARGS=()
MOUNT_ARGS+=("--mount" "type=bind,source=/nix,target=/nix")
MOUNT_ARGS+=("--mount" "type=bind,source=$HOME/.config/git/ignore,target=/home/vscode/.config/git/ignore")
MOUNT_ARGS+=("--mount" "type=bind,source=${CLAUDE_CONFIG_DIR:-$HOME/.claude},target=/home/vscode/.claude")
[ -n "$GIT_COMMON_DIR" ] && [[ $GIT_COMMON_DIR != "$GIT_ROOT" ]] && MOUNT_ARGS+=("--mount" "type=bind,source=$GIT_COMMON_DIR,target=$GIT_COMMON_DIR")

# 3. 起動
devcontainer up "${COMMON_OPTS[@]}" "${MOUNT_ARGS[@]}"

# 4. Git 設定の注入 & シェル起動
devcontainer exec "${COMMON_OPTS[@]}" git config --global --add safe.directory '*'
[ -n "$U_NAME" ] && devcontainer exec "${COMMON_OPTS[@]}" git config --global user.name "$U_NAME"
[ -n "$U_EMAIL" ] && devcontainer exec "${COMMON_OPTS[@]}" git config --global user.email "$U_EMAIL"

devcontainer exec "${COMMON_OPTS[@]}" /bin/bash
