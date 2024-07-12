{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        padding = 12;
        horizontal_padding = 16;
        offset = "16x68";
        transparency = 0;
        corner_radius = 8;
        width = 442;
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

      # skip_rule = {
      #   appname = "*";
      #   skip_display = true;
      # };
    };
  };
}
