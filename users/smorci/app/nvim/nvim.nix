pkgs:
{
  enable = true;

  defaultEditor = true;

  plugins = with pkgs.vimPlugins; [
    
    # Syntax and language specific
    vim-json
    vim-go
    vim-nix
    vim-terraform
    vim-markdown
    vim-yaml

    # LSP
    nvim-lspconfig
    lsp-status-nvim

    # Autocomplete
    nvim-cmp
    cmp-buffer
    cmp-nvim-lsp
    cmp-path
    cmp-cmdline
    cmp-treesitter

    # Snippets
    cmp-vsnip
    vim-vsnip

    # Quality of coding
    vim-gitgutter
    vim-commentary
    vim-airline
    vim-surround
    nvim-treesitter
    telescope-nvim
    indentLine
    vim-visual-multi

    # Colorscheme
    everforest
 ];

  extraConfig = ''
        luafile ~/.dotfiles/users/smorci/app/nvim/lua/settings.lua

        function! LspStatus() abort
          if luaeval('#vim.lsp.buf_get_clients() > 0')
            return luaeval("require('lsp-status').status()")
          endif

          return '''
        endfunction

      '';
}
