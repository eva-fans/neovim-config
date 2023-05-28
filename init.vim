if exists('g:vscode')
    " VSCode extension
else
    " ordinary Neovim
	call plug#begin()
	" The default plugin directory will be as follows:
	"   - Vim (Linux/macOS): '~/.vim/plugged'
	"   - Vim (Windows): '~/vimfiles/plugged'
	"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
	" You can specify a custom plugin directory by passing it as the argument
	"   - e.g. `call plug#begin('~/.vim/plugged')`
	"   - Avoid using standard Vim directory names like 'plugin'

	" Make sure you use single quotes

	" vimspector - A multi language graphical debugger for Vim
	Plug 'puremourning/vimspector'

	" Use release branch (recommended)
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" vim-cpp-modern: Enhanced C and C++ syntax highlighting
	Plug 'bfrg/vim-cpp-modern'

	" Automatic input method switching for vim
	Plug 'rlue/vim-barbaric'

	" A Lua rewrite of vim-lastplace
	Plug 'ethanholz/nvim-lastplace'

	" lean & mean status/tabline for vim that's light as air 
	Plug 'vim-airline/vim-airline'

	" Simple tmux statusline generator with support for powerline symbols and statusline / airline / lightline integration 
	Plug 'edkolev/tmuxline.vim'
	
	" A command-line fuzzy finder 
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }


	" Initialize plugin system
	" - Automatically executes `filetype plugin indent on` and `syntax enable`.
	call plug#end()
	" You can revert the settings after the call like so:
	"   filetype indent off   " Disable file-type-specific indentation
	"   syntax off            " Disable syntax highlighting
	
	" Automatically displays all buffers when there's only one tab open.
	let g:airline#extensions#tabline#enabled = 1
	" Show bufnr
	let g:airline#extensions#tabline#buffer_nr_show = 1
	" show relative line number
	set relativenumber
	
	" use system clipboard
	set clipboard+=unnamedplus

	" set the tab width	
	set shiftwidth=4 smarttab
	set tabstop=8 softtabstop=0

	" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
	" delays and poor user experience
	set updatetime=100

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved
	set signcolumn=yes

	" Use tab for trigger completion with characters ahead and navigate
	" NOTE: There's always complete item selected by default, you may want to enable
	" no select by `"suggest.noselect": true` in your configuration file
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config
	inoremap <silent><expr> <TAB>
	      \ coc#pum#visible() ? coc#pum#next(1) :
	      \ CheckBackspace() ? "\<Tab>" :
	      \ coc#refresh()
	inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

	" Make <CR> to accept selected completion item or notify coc.nvim to format
	" <C-g>u breaks current undo, please make your own choice
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
				      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

	function! CheckBackspace() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction	

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window
	nnoremap <silent> K :call ShowDocumentation()<CR>

	" Use <c-e> to show explorer
	nnoremap <silent> <c-e> :CocCommand explorer<CR>

	" Use <c-f> to show fzf finder
	nnoremap <silent> <c-f> :FZF<CR>

	" Use <c-p> to run coc command
	nnoremap <silent> <c-p> :CocCommand 

	" Use <m-q> to swith to the prevoius buffer
	nnoremap <silent> <m-q> :bp<CR>

	" Use <m-e> to switch the next buffer
	nnoremap <silent> <m-e> :bn<CR>

	function! ShowDocumentation()
	  if CocAction('hasProvider', 'hover')
	    call CocActionAsync('doHover')
	  else
	    call feedkeys('K', 'in')
	  endif
	endfunction

	" Highlight the symbol and its references when holding the cursor
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming
	nmap <leader>rn <Plug>(coc-rename)	

	" Formatting selected code
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
	  autocmd!
	  " Setup formatexpr specified filetype(s)
	  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	  " Update signature help on jump placeholder
	  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying code actions to the selected code block
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying code actions at the cursor position
	nmap <leader>ac  <Plug>(coc-codeaction-cursor)
	" Remap keys for apply code actions affect whole buffer
	nmap <leader>as  <Plug>(coc-codeaction-source)
	" Apply the most preferred quickfix action to fix diagnostic on the current line
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Remap keys for applying refactor code actions
	nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
	xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
	nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
	
	" Run the Code Lens action on the current line
	nmap <leader>cl  <Plug>(coc-codelens-action)

	" Map function and class text objects
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server
	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)
	xmap ic <Plug>(coc-classobj-i)
	omap ic <Plug>(coc-classobj-i)
	xmap ac <Plug>(coc-classobj-a)
	omap ac <Plug>(coc-classobj-a)

	
	
	" Use CTRL-S for selections ranges
	" Requires 'textDocument/selectionRange' support of language server
	nmap <silent> <C-a> <Plug>(coc-range-select)
	xmap <silent> <C-a> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer
	command! -nargs=0 Format :call CocActionAsync('format')

	" Add `:Fold` command to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	
	" Add `:OR` command for organize imports of the current buffer
	command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Mappings for CoCList
	" Show all diagnostics
	nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions
	nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" Show commands
	nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document
	nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols
	nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item
	nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item
	nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list
	nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

	" Remap <C-d> and <C-u> to scroll float windows/popups
	if has('nvim-0.4.0') || has('patch-8.2.0750')
	  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	  inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	  inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	endif

	lua require'nvim-lastplace'.setup{}

	let g:lastplace_ignore_buftype = "quickfix,nofile,help"
	let g:lastplace_ignore_filetype = "gitcommit,gitrebase,svn,hgcommit"
	let g:lastplace_open_folds = 1

endif
