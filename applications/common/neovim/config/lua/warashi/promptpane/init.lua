-- バッファ作成時のセットアップ用コマンド
-- 例: :e promptpane://tmux/1
vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "promptpane://tmux/*",
	callback = function(args)
		local buf = args.buf
		-- 通常のファイル保存を無効化し、専用バッファとして扱う
		vim.bo[buf].filetype = "promptpane"
		vim.bo[buf].buftype = "acwrite"
		vim.bo[buf].swapfile = false
		vim.api.nvim_set_option_value("modified", false, { buf = buf })
	end,
})

-- :w 実行時のフック（送信処理）
vim.api.nvim_create_autocmd("BufWriteCmd", {
	pattern = "promptpane://tmux/*",
	callback = function(args)
		local buf = args.buf
		local uri = args.file

		-- URIから pane_id を抽出 (例: promptpane://tmux/1 -> 1)
		local pane_id = uri:match("promptpane://tmux/(.+)")
		if not pane_id or pane_id == "" then
			vim.notify("[PromptPane] 無効なURIフォーマットです: " .. uri, vim.log.levels.ERROR)
			return
		end

		-- バッファの内容を取得し、単一の文字列（末尾改行なし）に結合。
		-- この時、改行は ESC[13;3u にすることで M-Enter 相当にし、最後に ESC[13u をつけることで Enter 相当も一気に送る。
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		local payload = table.concat(lines, "\x1B[13;3u") .. "\x1B[13u"

		-- シェルを経由せず、直接tmuxプロセスにバイト列として引数を渡す（結合・複雑性の極小化）
		-- 1. まず、テキストを完全に安全なリテラル（-l）として送信する
		-- -l: リテラルとしてパース
		-- --: 以降の文字列をオプションとして扱わない（ハイフン始まりのプロンプト対策）
		local obj_text = vim.system({
			"tmux",
			"send-keys",
			"-t",
			pane_id,
			"-l",
			"--",
			payload,
		}, { text = true }):wait()

		if obj_text.code ~= 0 then
			local err_msg = obj_text.stderr and obj_text.stderr:gsub("%s+$", "") or "Unknown Error"
			vim.notify("[PromptPane] 送信失敗: " .. err_msg, vim.log.levels.ERROR)
			return
		end

		-- 送信成功: バッファをクリアし、未編集状態に戻す（Editing状態への回帰）
		-- ※Undoツリーは維持されるため、`u` で直前のプロンプトを復元可能
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "" })
		vim.api.nvim_set_option_value("modified", false, { buf = buf })
		vim.notify("[PromptPane] 完了: Pane " .. pane_id .. " へ送信・実行しました", vim.log.levels.INFO)
	end,
})
