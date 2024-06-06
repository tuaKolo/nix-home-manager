{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pacman";
  home.homeDirectory = "/home/pacman";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # TOOL CLI
	# Development
	helix
	jq
	git-crypt
	tig
	tree-sitter
	
	# Files
	ranger
	trash-cli
	zstd
	restic
	fzf

	# Media
	youtube-dl
	imagemagick

	# Internet
	aria
	axel
	speedtest-cli

	# Overview
	wtf
	lazygit
	neofetch
	htop

	# bat
	# exa diganti menjadi eza
	# fish
	# starship
	# zoxide
	# tmux
	# neovim
  ];


  # Install dan Config
  # BAT
  programs.bat= {
	enable = true;
	config = {
	  pager = "less -FR";
	  theme = "Dracula";
	};
  };
  
  # EXA
  programs.eza= {
	enable = true;
	enableBashIntegration = true;
	enableFishIntegration = true;
	icons = true;
#	config = {
#	  ls = "eza";
#	  ll = "eza -l";
#	  la = "eza -a";
#	  lt = "eza --tree";
#	  lla = "eza -la" ;
#	};
  };
  
  # FISH
  programs.fish= {
	enable = true;
	shellAbbrs = {
	  cp = "cp -iv";
	  mv = "mv iv";
	  rm = "trash-put";
	  cat = "bat";
	  ls = "eza --grid --icons";
	  ll = "eza -l --grid --icons";
	  la = "eza -a --grid --icons";
	  lt = "eza --tree --grid --icons";
	  lla = "eza -la --grid --icons";
	  gst = "git status";
          gco = "git checkout";
          gcm = "git commit -m";
          gpull = "git pull";
          gpush = "git push";
        };
  };

  # NUSHELL
  programs.nushell = {
    enable = true;
  };

  # STARSHIP
  programs.starship = {
	enable = true;
	enableBashIntegration = true;
	enableFishIntegration = true;	
  };

  # ZOXIDE
  programs.zoxide = {
  	enable = true;
	enableBashIntegration = true;
	enableFishIntegration = true;

  };
  
  # TMUX
  programs.tmux = {
	enable = true;
	shortcut = "a";
	mouse = true;
        aggressiveResize = true;
        baseIndex = 1;
        newSession = true;
        escapeTime = 500;
        clock24 = false;
        terminal = "screen-256color";
        sensibleOnTop = true;
	plugins = with pkgs.tmuxPlugins; [
	  # sensible
	  pain-control
	  yank
	  prefix-highlight
	  better-mouse-mode
	];
  };

  # NEOVIM
  programs.neovim = {
  	enable = true;
	viAlias = true;
	vimAlias = true;
	withPython3 = true;
	plugins = with pkgs.vimPlugins; [
	  # neovim-sensible
	  nvim-surround
	  nvim-treesitter
	  vim-vsnip
	  cmp-vsnip
	  {
	    plugin = nvim-cmp;
	    type = "lua";
	    config = '' 
		 local cmp = require'cmp'

  			cmp.setup({
    			snippet = {
     			 -- REQUIRED - you must specify a snippet engine
      			expand = function(args)
        		vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        		-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        		-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        		-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        		-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      			end,
    			},
    			window = {
      			-- completion = cmp.config.window.bordered(),
     			-- documentation = cmp.config.window.bordered(),
    			},
    			mapping = cmp.mapping.preset.insert({
      			['<C-b>'] = cmp.mapping.scroll_docs(-4),
      			['<C-f>'] = cmp.mapping.scroll_docs(4),
     			['<C-Space>'] = cmp.mapping.complete(),
      			['<C-e>'] = cmp.mapping.abort(),
      			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    			}),
    			sources = cmp.config.sources({
      			{ name = 'nvim_lsp' },
      			{ name = 'vsnip' }, -- For vsnip users.
      			-- { name = 'luasnip' }, -- For luasnip users.
      			-- { name = 'ultisnips' }, -- For ultisnips users.
      			-- { name = 'snippy' }, -- For snippy users.
    			}, {
      			{ name = 'buffer' },
    			})
  			})
	    '';
	  }
	  {
	    plugin = cmp-nvim-lsp;
	    type = "lua";
	    config = '' 
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
 		require('lspconfig')['pyright'].setup {
    		capabilities = capabilities
  		}
	    '';
	  }
	  #lazy lsp guide
	  {
	    plugin = lazy-lsp-nvim;
	    type = "lua";
	    config = '' 
	      require('lazy-lsp').setup {
        	 excluded_servers = {"diagnosticls", "pylsp", "efm", "jedi_language_server"},
      	      }
	    '';
	  }

	   vim-airline
	   {
	      plugin = vim-airline-themes;
	      config = "let g:airline_theme='wombat'";
	   }
	  # vim-airline-themes
	  # vim-airline-clock
	  # vim-commantary
	  # vim-fugitive
	  # vim-gitgutter
	  # vim-indent-guides
	  {
            plugin = dracula-nvim;
            config = ''
              syntax enable
              colorscheme dracula
            '';
          }
	];
	extraConfig = ''	  	  
	  set cursorline
	  set scrolloff=5	  
	'';

  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pacman/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };


}
