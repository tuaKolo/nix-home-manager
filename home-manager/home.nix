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
	  ls = "eza --grid --iconss";
	  ll = "eza -l --grid --icons";
	  la = "eza -a --grid --icons";
	  lt = "eza --tree --grid --icons";
	  lla = "eza -la --grid --icons";
	};
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
	plugins = with pkgs.tmuxPlugins; [
	  sensible
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
	  neovim-sensible
	  nvim-surround
	  nvim-treesitter
	  nvim-cmp
	  vim-airline
	  vim-airline-themes
	  # vim-airline-clock
	  # vim-commantary
	  # vim-fugitive
	  vim-gitgutter
	  vim-indent-guides
	  dracula-nvim
	];
	extraConfig = ''
	  syntax enable
	  colorscheme dracula
	  set cursorline
	  set scrolloff=5
	  let g:airline_theme='wombat'
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
