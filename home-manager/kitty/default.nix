{
  programs.kitty = {
    enable = true;

    theme = "Catppuccin-Mocha";

    settings = { 
      font_family = "DejaVuSansM Nerd Font Mono";
      font_size = 10;
      text_composition_strategy = "legacy";
      draw_minimal_borders = true;
      window_border_width = 0;
      window_padding_width = 14;
      adjust_line_height = 3;
      scrollback_pager = "nvim --noplugin -c \"silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer - \"";
    };
  };
}
