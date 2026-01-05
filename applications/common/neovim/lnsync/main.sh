src=${1:?usage: $0 SRC_DIR DST_DIR}
dst=${2:?usage: $0 SRC_DIR DST_DIR}

src_abs="$(readlink -f "$src")"

dst_abs="$(readlink -f "$dst" 2>/dev/null || true)"
if [[ -z ${dst_abs} ]]; then
  dst_parent="$(readlink -f "$(dirname "$dst")")"
  dst_abs="$dst_parent/$(basename "$dst")"
fi

case "$dst_abs/" in
"$src_abs/"*)
  echo "ERROR: DST must not be inside SRC" >&2
  exit 2
  ;;
esac

mkdir -p "$dst_abs"

echo "==> SRC: $src_abs" >&2
echo "==> DST: $dst_abs" >&2

########################################
# ディレクトリ作成フェーズ
########################################

echo "==> Scanning directories..." >&2
dir_total=$(find -L "$src_abs" -type d | wc -l | tr -d ' ')
dir_count=0

find -L "$src_abs" -type d -print0 |
  while IFS= read -r -d '' d; do
    ((++dir_count))
    rel="${d#"$src_abs"/}"

    printf '\r[DIR ] %6d / %6d : %s' \
      "$dir_count" "$dir_total" "$rel" >&2

    if [[ $d == "$src_abs" ]]; then
      mkdir -p "$dst_abs"
    else
      mkdir -p "$dst_abs/$rel"
    fi
  done

echo >&2
echo "==> Directories done ($dir_total)" >&2

########################################
# ファイル symlink フェーズ
########################################

echo "==> Scanning files..." >&2
file_total=$(find -L "$src_abs" -type f | wc -l | tr -d ' ')
file_count=0

find -L "$src_abs" -type f -print0 |
  while IFS= read -r -d '' f; do
    ((++file_count))
    rel="${f#"$src_abs"/}"
    out="$dst_abs/$rel"
    target="$(readlink -f "$f")"

    printf '\r[FILE] %6d / %6d : %s' \
      "$file_count" "$file_total" "$rel" >&2

    rm -f "$out"
    ln -s "$target" "$out"
  done

echo >&2
echo "==> Files done ($file_total)" >&2
echo "==> Finished" >&2
