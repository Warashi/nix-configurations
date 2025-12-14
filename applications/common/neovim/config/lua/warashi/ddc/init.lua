vim.cmd([[
  " --------------------------------------------------
  "  DDC Configuration
  " --------------------------------------------------
  call ddc#custom#load_config('@ddc_config_ts@')
  
  inoremap <C-n> <Cmd>call pum#map#select_relative(+1)<CR>
  inoremap <C-p> <Cmd>call pum#map#select_relative(-1)<CR>
  inoremap <C-y> <Cmd>call pum#map#confirm_suffix()<CR>
  
  call ddc#enable()
]])
