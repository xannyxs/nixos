{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    st
  ];

  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: {
        pname = "st-custom";
        version = "unstable";
        src = inputs.st-src;
        buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
      });
    })
  ];
}
