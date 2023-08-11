{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        padding = 12;
        horizontal_padding = 16;
        offset = "30x12";
        transparency = 10;
        corner_radius = 12;
        shrink = true;

        font = "DejaVuSansM Nerd Font Mono 9";
        line_height = 0;

        frame_width = 2;
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };

      urgency_low = {
        frame_color = "#45475a";
      };

      urgency_normal = {
        frame_color = "#89b4fa";
      };

      urgency_critical = {
        frame_color = "#f38ba8";
      };
    };
  };
}
