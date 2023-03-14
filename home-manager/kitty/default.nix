{
  programs.kitty = {
    enable = true;

    theme = "Catppuccin-Mocha";

    settings = { 
      font_family = "DejaVuSansMono Nerd Font Mono";
      font_size = 10;
      window_margin_width = 10;
      adjust_line_height = 2;
      scrollback_pager = "nvim -c 'set nonumber ft=man nolist showtabline=0 foldcolumn=0' -c 'autocmd TermOpen * normal G' -c 'silent write /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer -'";
    };
  };
}
