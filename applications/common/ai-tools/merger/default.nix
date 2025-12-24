{
  remarshal,
  jq,
  writeShellApplication,
}:
writeShellApplication {
  name = "config-merger";
  runtimeInputs = [
    # keep-sorted start
    jq
    remarshal
    # keep-sorted end
  ];
  text = ''
    if [ "$#" -lt 3 ]; then
      echo "Usage: $0 <output-format> <output-file> <input-file1> [<input-file2> ...]" >&2
      echo "Example: $0 json output.toml config1.yaml config2.json" >&2
      exit 1
    fi

    output_format="$1"
    shift

    output_file="$1"
    shift

    get_input_format() {
      case "$1" in
        *.json) echo "json" ;;
        *.yaml | *.yml) echo "yaml" ;;
        *.toml) echo "toml" ;;
        *.ini) echo "ini" ;;
        *) echo >&2 "Unsupported input file format: $1" ; exit 1 ;;
      esac
    }

    # Merge all input files into a single JSON object
    merged_json="{}"
    for input_file in "$@"; do
      input_format="$(get_input_format "$input_file")"
      input_json=$(remarshal --from "$input_format" --to json "$input_file")
      merged_json=$(echo "$merged_json" | jq --argjson new "$input_json" '. * $new')
    done

    # Convert merged JSON to the desired output format
    remarshal --output "$output_file" --from json --to "$output_format" <<< "$merged_json"
  '';
}
