import { BaseConfig, ConfigArguments } from "jsr:@shougo/ddc-vim@10.1.0/config";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "pum",
      autoCompleteEvents: [
        "CmdlineEnter",
        "CmdlineChanged",
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "TextChangedT",
      ],
      sources: [
        "lsp",
        "around",
        "buffer",
        "file",
        "skkeleton",
        "skkeleton_okuri",
      ],
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: [
            "matcher_head",
            "matcher_prefix",
            "matcher_length",
          ],
          sorters: [
            "sorter_rank",
          ],
          converters: [
            "converter_remove_overlap",
          ],
          timeout: 1000,
        },
        around: {
          mark: "A",
        },
        buffer: {
          mark: "B",
        },
        file: {
          mark: "F",
          isVolatile: true,
          forceCompletionPattern: String.raw`\S/\S*`,
        },
        lsp: {
          mark: "lsp",
          forceCompletionPattern: String.raw`\.\w*|::\w*|->\w*`,
          dup: "force",
          sorters: [
            "sorter_lsp_kind",
          ],
        },
        skkeleton: {
          mark: "skk",
          matchers: [],
          sorters: [],
          minAutoCompleteLength: 1,
          isVolatile: true,
        },
        skkeleton_okuri: {
          mark: "skk*",
          matchers: [],
          sorters: [],
          minAutoCompleteLength: 2,
          isVolatile: true,
        },
      },
      sourceParams: {
        lsp: {
          enableAdditionalTextEdit: true,
          enableDisplayDetail: true,
          enableMatchLabel: true,
          enableResolveItem: true,
        },
      },
      postFilters: [
        "sorter_head",
      ],
    });
  }
}
