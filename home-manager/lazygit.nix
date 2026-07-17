{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers = [
          {
            colorArg = "always";
            pager = "delta --color-only --dark --paging=never";
          }
        ];
      };

      git.log = {
        showGraph = "always";
      };

      gui = {
        nerdFontsVersion = "3";
      };

      os = {
        editPreset = "nvim";
      };
    };
  };
}
